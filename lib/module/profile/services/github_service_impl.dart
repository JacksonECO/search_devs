import 'package:search_devs/module/profile/exception/github_exception.dart';
import 'package:search_devs/module/profile/models/repository_github_model.dart';
import 'package:search_devs/module/profile/models/user_github_model.dart';
import 'package:search_devs/module/profile/services/github_service.dart';
import 'package:http/http.dart';

class GitHubServiceImpl implements GitHubService {
  final Client _client;
  final _uriBase = Uri.https('api.github.com');

  GitHubServiceImpl({required Client client}) : _client = client;

  @override
  Future<UserGitHubModel> getUser(String username) async {
    final response = await _client.get(_uriBase.replace(path: '/users/$username'));

    if (response.statusCode == 200) {
      return UserGitHubModel.fromJson(response.body);
    } else if (response.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw GitHubException();
    }
  }

  @override
  Future<List<RepositoryGitHubModel>> getRepositories(String username) async {
    final response = await _client.get(_uriBase.replace(path: '/users/$username/repos'));

    if (response.statusCode == 200) {
      return RepositoryGitHubModel.fromJsonList(response.body);
    } else if (response.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw GitHubException();
    }
  }
}
