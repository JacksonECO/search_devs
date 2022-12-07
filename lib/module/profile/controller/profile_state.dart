import 'package:search_devs/module/profile/models/repository_github_model.dart';
import 'package:search_devs/module/profile/models/user_github_model.dart';

abstract class ProfileState {
  final UserGitHubModel? user;
  final List<RepositoryGitHubModel>? repositories;

  ProfileState({
    this.user,
    this.repositories,
  });
}

class ProfileStateLoading extends ProfileState {}

class ProfileStateFailure extends ProfileState {
  final String message;

  ProfileStateFailure(this.message);
}

class ProfileStateSuccess extends ProfileState {
  ProfileStateSuccess({
    required super.repositories,
    required super.user,
  });
}
