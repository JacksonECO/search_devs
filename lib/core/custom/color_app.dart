import 'package:flutter/material.dart';

class ColorApp {
  ColorApp._();
  static final ColorApp _instance = ColorApp._();
  static ColorApp get i => _instance;

  /// 0xFF4A5568
  Color get independence => const Color(0xFF4A5568);

  /// 0xFF2D3748
  Color get japaneseIndigo => const Color(0xFF2D3748);

  /// 0xFF171923 or 0xFF1C1B1F
  Color get eerieBlack => const Color(0xFF171923);

  /// 0xFFEADDFF
  Color get lavender => const Color(0xFFEADDFF);

  /// 0xFFE2E8F0
  Color get azureishWhite => const Color(0xFFE2E8F0);

  /// 0xFF79747E
  Color get sonicSilver => const Color(0xFF79747E);

  /// 0xFF49454F
  Color get quartz => const Color(0xFF49454F);
}

extension ColorAppExtension on BuildContext {
  ColorApp get colors => ColorApp.i;
}
