import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_devs/module/profile/controller/profile_bloc.dart';
import 'package:search_devs/module/profile/controller/profile_event.dart';
import 'package:search_devs/module/profile/controller/profile_state.dart';
import 'package:search_devs/module/profile/exception/github_exception.dart';
import 'package:search_devs/module/profile/models/repository_github_model.dart';
import 'package:search_devs/module/profile/models/user_github_model.dart';
import 'package:search_devs/module/profile/services/github_service.dart';

class MockGitHubService extends Mock implements GitHubService {}

void main() {
  final user = UserGitHubModel(
    login: 'username',
    id: 1,
    avatarUrl: 'https://picsum.photos/200',
    name: 'name',
    publicRepos: 4,
    followers: 2,
    following: 4,
  );

  final repository = RepositoryGitHubModel(
    name: 'name',
    owner: 'owner',
    description: 'description',
    language: 'language',
    stargazersCount: 2,
    updatedAt: DateTime.now(),
  );
  final repository2 = RepositoryGitHubModel(
    name: 'name',
    owner: 'owner',
    description: 'description',
    language: 'language',
    stargazersCount: 2,
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  );

  testWidgets('Garantindo ProfileBloc com status ProfileStateSuccess', (tester) async {
    var mockGitHubService = MockGitHubService();
    var bloc = ProfileBloc(postService: mockGitHubService);

    when(() => mockGitHubService.getUser('username')).thenAnswer((_) async => user);
    when(() => mockGitHubService.getRepositories('username')).thenAnswer((_) async => [
          repository,
          repository2,
        ]);

    expect(bloc.state, isA<ProfileStateLoading>());

    bloc.add(ProfileEventSearch(username: 'username'));
    await expectLater(
        bloc.stream, emitsInOrder([isA<ProfileStateLoading>(), isA<ProfileStateSuccess>()]));

    bloc.close();
  });

  testWidgets('Garantindo ProfileBloc com status ProfileStateFailure', (tester) async {
    var mockGitHubService = MockGitHubService();
    var bloc = ProfileBloc(postService: mockGitHubService);

    when(() => mockGitHubService.getUser('username')).thenThrow(GitHubException('errorMessage'));
    when(() => mockGitHubService.getRepositories('username')).thenAnswer((_) async => [repository]);

    expect(bloc.state, isA<ProfileStateLoading>());

    bloc.add(ProfileEventSearch(username: 'username'));
    await expectLater(
        bloc.stream, emitsInOrder([isA<ProfileStateLoading>(), isA<ProfileStateFailure>()]));

    //

    when(() => mockGitHubService.getUser('username')).thenAnswer((_) async => user);
    when(() => mockGitHubService.getRepositories('username')).thenThrow(Exception('errorMessage'));

    bloc.add(ProfileEventSearch(username: 'username'));
    await expectLater(
        bloc.stream, emitsInOrder([isA<ProfileStateLoading>(), isA<ProfileStateFailure>()]));

    bloc.close();
  });
}
