import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:search_devs/module/profile/exception/github_exception.dart';
import 'package:search_devs/module/profile/models/repository_github_model.dart';
import 'package:search_devs/module/profile/models/user_github_model.dart';
import 'package:search_devs/module/profile/services/github_service_impl.dart';

@GenerateMocks([Client])
void main() {
  var userGitHubModel = UserGitHubModel(
    login: 'login',
    id: 1,
    avatarUrl: 'avatarUrl',
    name: 'name',
    bio: 'bio',
    location: 'location',
    publicRepos: 1,
    followers: 1,
    following: 1,
  );

  var repositoryGitHubModel = RepositoryGitHubModel(
    name: 'name',
    description: 'description',
    language: 'Dart',
    stargazersCount: 1,
    updatedAt: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
  );

  fn(Request request) async {
    if (request.url.path.contains('/users/')) {
      if (request.url.path.contains('/repos')) {
        return Response('[${repositoryGitHubModel.toJson()}]', 200);
      }
      return Response(userGitHubModel.toJson(), 200);
    }
    throw Response('''{
  "message": "Not Found",
  "documentation_url": "https://docs.github.com/rest/"
}''', 400);
  }

  final service = GitHubServiceImpl(client: MockClient(fn));

  test('Garantindo funcionamento correto caso seja passar um username existente', () async {
    final user = await service.getUser('username');
    expect(user, isA<UserGitHubModel>());

    final repositories = await service.getRepositories('username');
    expect(repositories, isA<List<RepositoryGitHubModel>>());
  });

  test('Garantindo lançamento de UserNotFoundException se erro 404 em getUser', () async {
    fn2(Request request) async => Response('', 404);
    final service = GitHubServiceImpl(client: MockClient(fn2));

    expect(() async => await service.getUser('username'), throwsA(isA<UserNotFoundException>()));
  });

  test('Garantindo lançamento de UserNotFoundException se erro 404 em getRepositories', () async {
    fn2(Request request) async => Response('', 404);
    final service2 = GitHubServiceImpl(client: MockClient(fn2));

    expect(() async => await service2.getRepositories('username'),
        throwsA(isA<UserNotFoundException>()));
  });

  test('Garantindo lançamento de GitHubException qualquer outro erro em getUser', () async {
    fn2(Request request) async => Response('', 400);
    final service = GitHubServiceImpl(client: MockClient(fn2));

    expect(() async => await service.getUser('username'), throwsA(isA<GitHubException>()));
  });

  test('Garantindo lançamento de GitHubException qualquer outro erro em getRepositories', () async {
    fn2(Request request) async => Response('', 400);
    final service2 = GitHubServiceImpl(client: MockClient(fn2));

    expect(() async => await service2.getRepositories('username'), throwsA(isA<GitHubException>()));
  });
}
