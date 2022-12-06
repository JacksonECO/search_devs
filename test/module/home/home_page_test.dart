import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_devs/module/home/home_page.dart';

void main() {
  testWidgets('Garantir abertura da HomePage', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    expect(find.image(const AssetImage('assets/imgs/logo.png')), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Buscar'), findsOneWidget);
  });

  testWidgets('Garantir ação ao detectar um TextInputAction.done', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    var textForm = find.widgetWithText(TextFormField, 'Buscar');
    expect(textForm, findsOneWidget);

    await tester.enterText(textForm, 'myUsername');
    await tester.testTextInput.receiveAction(TextInputAction.done);
  });
}
