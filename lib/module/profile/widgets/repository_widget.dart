import 'package:flutter/material.dart';
import 'package:search_devs/core/custom/style_app.dart';
import 'package:search_devs/core/helps/my_icons.dart';
import 'package:search_devs/core/helps/string_formatter.dart';
import 'package:search_devs/module/profile/models/repository_github_model.dart';
import 'package:search_devs/module/profile/widgets/icon_name_tile.dart';

class RepositoryWidget extends StatelessWidget with StringFormatter {
  final RepositoryGitHubModel repository;
  const RepositoryWidget({required this.repository, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(repository.name, style: context.styles.title),
          const SizedBox(height: 16),
          Text(repository.description ?? 'Sem descrição', style: context.styles.body),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconNameTile(icon: MyIcons.star, name: numSuffix(repository.stargazersCount)),
              const SizedBox(width: 8),
              Text('.', style: context.styles.body.copyWith(height: 0.35, fontSize: 25)),
              const SizedBox(width: 8),
              Text('Atualizado há ', style: context.styles.body),
              Text(lastTimer(repository.updatedAt))
            ],
          ),
        ],
      ),
    );
  }
}
