import 'package:flutter/material.dart';
import 'package:search_devs/core/custom/color_app.dart';
import 'package:search_devs/core/custom/style_app.dart';
import 'package:search_devs/core/helps/string_formatter.dart';
import 'package:search_devs/module/profile/models/user_github_model.dart';
import 'package:search_devs/module/profile/widgets/icon_name_tile.dart';

class UserWidget extends StatelessWidget with StringFormatter {
  final UserGitHubModel user;
  const UserWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.lavender,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 48 / 2,
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: context.styles.title,
                    ),
                    Text(
                      '@${user.login}',
                      style: context.styles.captions.copyWith(color: context.colors.japaneseIndigo),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconNameTile(icon: Icons.abc, name: '${numSuffix(user.followers)} seguidores'),
                const SizedBox(width: 15),
                IconNameTile(icon: Icons.abc, name: '${numSuffix(user.following)} seguindo'),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              user.bio ?? 'Sem biografia',
              style: context.styles.body,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            infoUserWidget(),
          ],
        ),
      ),
    );
  }

  Widget infoUserWidget() {
    List<Widget> list = [];

    if (user.company != null && user.company!.isNotEmpty) {
      list.add(IconNameTile(
        icon: Icons.abc,
        name: user.company!,
      ));
    }

    if (user.location != null && user.location!.isNotEmpty) {
      list.add(IconNameTile(
        icon: Icons.abc,
        name: user.location!,
      ));
    }

    if (user.email != null && user.email!.isNotEmpty) {
      list.add(IconNameTile(
        icon: Icons.abc,
        name: user.email!,
      ));
    }

    if (user.blog != null && user.blog!.isNotEmpty) {
      list.add(IconNameTile(
        icon: Icons.abc,
        name: user.blog!,
      ));
    }

    if (user.twitterUsername != null && user.twitterUsername!.isNotEmpty) {
      list.add(IconNameTile(
        icon: Icons.abc,
        name: user.twitterUsername!,
      ));
    }
    switch (list.length) {
      case 0:
        return const SizedBox();
      case 1:
      case 2:
      case 3:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: list);
      case 4:
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: list.sublist(0, 2)),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: list.sublist(2)),
          ],
        );
      default:
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: list.sublist(0, 3)),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: list.sublist(3)),
          ],
        );
    }
  }
}
