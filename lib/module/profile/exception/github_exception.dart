class GitHubException implements Exception {
  final String message;

  GitHubException([this.message = 'Aconteceu um erro inesperado, tente novamente mais tarde']);
}

class UserNotFoundException extends GitHubException {
  UserNotFoundException([super.message = 'Usuário não encontrado']);
}
