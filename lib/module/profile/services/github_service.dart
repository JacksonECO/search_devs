import 'package:search_devs/module/profile/models/repository_github_model.dart';
import 'package:search_devs/module/profile/models/user_github_model.dart';

abstract class GitHubService {
  Future<UserGitHubModel> getUser(String username);
  Future<List<RepositoryGitHubModel>> getRepositories(String username);
}
