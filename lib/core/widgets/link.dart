import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends InkWell {
  final String url;
  const Link({super.key, required this.url, required super.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      },
      child: child,
    );
  }
}
