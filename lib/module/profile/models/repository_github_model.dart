import 'dart:convert';

class RepositoryGitHubModel {
  final String name;
  final String? description;
  final String? language;
  final int stargazersCount;

  RepositoryGitHubModel({
    required this.name,
    this.description,
    this.language,
    required this.stargazersCount,
  });

  static List<RepositoryGitHubModel> fromJsonList(String json) {
    final List<dynamic> list = jsonDecode(json);
    return list.map((e) => RepositoryGitHubModel.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'language': language,
      'stargazers_count': stargazersCount,
    };
  }

  factory RepositoryGitHubModel.fromMap(Map<String, dynamic> map) {
    return RepositoryGitHubModel(
      name: map['name'] as String,
      description: map['description'] as String?,
      language: map['language'] as String?,
      stargazersCount: map['stargazers_count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepositoryGitHubModel.fromJson(String source) =>
      RepositoryGitHubModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RepositoryGitHubModel(name: $name, description: $description, language: $language, stargazersCount: $stargazersCount)';
  }
}
