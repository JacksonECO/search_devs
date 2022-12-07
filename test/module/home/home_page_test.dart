import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_devs/module/home/home_page.dart';

import '../../help_test/help_page_push.dart';

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
    final helperPage = await HelpPagePush.pumpWidget(
      tester: tester,
      child: const HomePage(),
      namePage: '/profile/',
    );

    var textForm = find.widgetWithText(TextFormField, 'Buscar');
    expect(textForm, findsOneWidget);

    await tester.enterText(textForm, 'myUsername');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.pump();

    expect(helperPage.finder, findsOneWidget);
  });
}
