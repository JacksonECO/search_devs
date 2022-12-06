import 'dart:convert';

class UserGitHubModel {
  final String login;
  final int id;
  final String avatarUrl;
  final String name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final String? bio;
  final String? twitterUsername;
  final int publicRepos;
  final int followers;
  final int following;

  UserGitHubModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.twitterUsername,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'name': name,
      'company': company,
      'blog': blog,
      'location': location,
      'email': email,
      'bio': bio,
      'twitter_username': twitterUsername,
      'public_repos': publicRepos,
      'followers': followers,
      'following': following,
    };
  }

  factory UserGitHubModel.fromMap(Map<String, dynamic> map) {
    return UserGitHubModel(
      login: map['login'] as String,
      id: map['id'] as int,
      avatarUrl: map['avatar_url'] as String,
      name: map['name'] as String,
      company: map['company'] as String?,
      blog: map['blog'] as String?,
      location: map['location'] as String?,
      email: map['email'] as String?,
      bio: map['bio'] as String?,
      twitterUsername: map['twitter_username'] as String?,
      publicRepos: map['public_repos'] as int,
      followers: map['followers'] as int,
      following: map['following'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserGitHubModel.fromJson(String source) =>
      UserGitHubModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserGitHubModel(login: $login, id: $id, avatarUrl: $avatarUrl, name: $name, company: $company, blog: $blog, location: $location, email: $email, bio: $bio, twitterUsername: $twitterUsername, publicRepos: $publicRepos, followers: $followers, following: $following)';
  }
}
