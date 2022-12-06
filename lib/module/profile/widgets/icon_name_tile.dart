import 'package:flutter/material.dart';
import 'package:search_devs/core/custom/color_app.dart';
import 'package:search_devs/core/custom/style_app.dart';

class IconNameTile extends StatelessWidget {
  final IconData icon;
  final String name;
  const IconNameTile({
    required this.icon,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: context.colors.independence,
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: context.styles.body,
        ),
      ],
    );
  }
}
