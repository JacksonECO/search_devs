import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'package:search_devs/module/profile/controller/profile_bloc.dart';
import 'package:search_devs/module/profile/controller/profile_state.dart';
import 'package:search_devs/module/profile/models/repository_github_model.dart';
import 'package:search_devs/module/profile/models/user_github_model.dart';
import 'package:search_devs/module/profile/profile_page.dart';
import 'package:search_devs/module/profile/widgets/repository_widget.dart';
import 'package:search_devs/module/profile/widgets/user_widget.dart';

class MockProfileBloc extends Mock implements ProfileBloc {}

void main() {
  late MockProfileBloc mockProfileBloc;

  var user = UserGitHubModel(
    login: 'username',
    id: 1,
    avatarUrl: 'https://picsum.photos/200',
    name: 'name',
    publicRepos: 4,
    followers: 2,
    following: 4,
  );

  var repository = RepositoryGitHubModel(
    name: 'name',
    description: 'description',
    language: 'language',
    stargazersCount: 2,
    updatedAt: DateTime.now(),
  );

  setUpAll(() {
    mockProfileBloc = MockProfileBloc();
    when(() => mockProfileBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockProfileBloc.close()).thenAnswer((_) => Future.value());
  });

  testWidgets('Garantir Profile para o estado em Loading', (tester) async {
    when(() => mockProfileBloc.state).thenAnswer((_) => ProfileStateLoading());

    await tester.pumpWidget(MaterialApp(
      home: ProfilePage(
        username: 'username',
        bloc: mockProfileBloc,
      ),
    ));

    expect(find.byType(ProfilePage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Garantir Profile para o estado Failure', (tester) async {
    when(() => mockProfileBloc.state).thenAnswer((_) => ProfileStateFailure('errorMessage'));

    await tester.pumpWidget(MaterialApp(
      home: ProfilePage(
        username: 'username',
        bloc: mockProfileBloc,
      ),
    ));

    expect(find.byType(ProfilePage), findsOneWidget);
    expect(find.text('errorMessage'), findsOneWidget);
  });

  testWidgets('Garantir Profile para o estado Success', (tester) async {
    when(() => mockProfileBloc.state).thenAnswer((_) => ProfileStateSuccess(
          repositories: [repository, repository],
          user: user,
        ));

    // Faz um HttpOverrides.runZoned para usar uma MockHttpClient e assim realizar um mock as imagens
    // Uma vez que não é permitido realizar requisições http em testes
    await mockNetworkImages(() async {
      await tester.pumpWidget(MaterialApp(
        home: ProfilePage(
          username: 'username',
          bloc: mockProfileBloc,
        ),
      ));

      expect(find.byType(ProfilePage), findsOneWidget);

      expect(find.byType(UserWidget), findsOneWidget);
      expect(find.byType(RepositoryWidget), findsNWidgets(2));
    });
  });

  testWidgets('Garantir Profile para o estado Success mas com user sem repositórios',
      (tester) async {
    when(() => mockProfileBloc.state).thenAnswer((_) => ProfileStateSuccess(
          repositories: [],
          user: user,
        ));
    await mockNetworkImages(() async {
      await tester.pumpWidget(MaterialApp(
        home: ProfilePage(
          username: 'username',
          bloc: mockProfileBloc,
        ),
      ));

      expect(find.byType(ProfilePage), findsOneWidget);

      expect(find.byType(UserWidget), findsOneWidget);
      expect(find.byType(RepositoryWidget), findsNothing);
      expect(find.text('Nenhum repositório encontrado!'), findsOneWidget);
    });
  });
}
