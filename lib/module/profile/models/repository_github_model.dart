import 'dart:convert';

class RepositoryGitHubModel {
  final String name;
  final String owner;
  final String? description;
  final String? language;
  final int stargazersCount;
  final DateTime updatedAt;

  RepositoryGitHubModel({
    required this.name,
    required this.owner,
    this.description,
    this.language,
    required this.stargazersCount,
    required this.updatedAt,
  });

  static List<RepositoryGitHubModel> fromJsonList(String json) {
    final List<dynamic> list = jsonDecode(json);
    return list.map((e) => RepositoryGitHubModel.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'owner': {'login': owner},
      'description': description,
      'language': language,
      'stargazers_count': stargazersCount,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory RepositoryGitHubModel.fromMap(Map<String, dynamic> map) {
    return RepositoryGitHubModel(
      name: map['name'] as String,
      owner: map['owner']['login'] as String,
      description: map['description'] as String?,
      language: map['language'] as String?,
      stargazersCount: map['stargazers_count'] as int,
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory RepositoryGitHubModel.fromJson(String source) =>
      RepositoryGitHubModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RepositoryGitHubModel(name: $name, owner: $owner, description: $description, language: $language, stargazersCount: $stargazersCount, updatedAt: $updatedAt)';
  }
}
