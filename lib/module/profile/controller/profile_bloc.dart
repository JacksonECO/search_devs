import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:search_devs/module/profile/controller/profile_event.dart';
import 'package:search_devs/module/profile/controller/profile_state.dart';
import 'package:search_devs/module/profile/exception/github_exception.dart';
import 'package:search_devs/module/profile/models/repository_github_model.dart';
import 'package:search_devs/module/profile/models/user_github_model.dart';
import 'package:search_devs/module/profile/services/github_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required GitHubService postService}) : super(ProfileStateLoading()) {
    on<ProfileEventSearch>((event, emit) async {
      emit(ProfileStateLoading());
      try {
        late final UserGitHubModel user;
        late final List<RepositoryGitHubModel> repositories;

        // As duas requisições são feitas ao mesmo tempo, e só depois que ambas forem concluídas
        // que passa para a próxima linha de código
        await Future.wait([
          postService.getUser(event.username).then((value) => user = value),
          postService.getRepositories(event.username).then((value) => repositories = value)
        ]);

        repositories.sort((a, b) {
          var sortStar = b.stargazersCount.compareTo(a.stargazersCount);
          if (sortStar != 0) return sortStar;
          return b.updatedAt.compareTo(a.updatedAt);
        });

        emit(ProfileStateSuccess(user: user, repositories: repositories));
      } on GitHubException catch (e) {
        emit(ProfileStateFailure(e.message));
      } catch (e) {
        log(e.toString());
        emit(ProfileStateFailure('Tente novamente mais tarde!'));
      }
    });
  }
}
