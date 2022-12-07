import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_devs/core/custom/color_app.dart';
import 'package:search_devs/core/custom/style_app.dart';
import 'package:search_devs/core/helps/my_icons.dart';

class IconNameTile extends StatelessWidget {
  final MyIcons icon;
  final String name;
  const IconNameTile({
    required this.icon,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon.path,
          color: context.colors.independence,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            name,
            style: context.styles.body,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
