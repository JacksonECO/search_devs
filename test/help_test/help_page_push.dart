import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: must_be_immutable
class HelpPagePush extends StatelessWidget {
  static const _pageKey = Key('HelpPagePush');
  dynamic valuePop;
  Object? args;
  bool? canPop;

  final Widget homePage;
  final WidgetTester tester;
  final NavigatorObserver? navigatorObserver;
  HelpPagePush._({
    required this.homePage,
    required this.tester,
    this.navigatorObserver,
    this.valuePop,
  });

  Finder get finder => find.byKey(_pageKey);

  Future<void> tapPop() async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  static Future<HelpPagePush> pumpWidget({
    required WidgetTester tester,
    required Widget child,
    required String namePage,
    dynamic valuePop = true,
    NavigatorObserver? navigator,
  }) async {
    var screenHelp = HelpPagePush._(
      tester: tester,
      valuePop: valuePop,
      homePage: child,
      navigatorObserver: navigator,
    );

    await tester.pumpWidget(MaterialApp(
      home: child,
      navigatorObservers:
          screenHelp.navigatorObserver == null ? [] : [screenHelp.navigatorObserver!],
      routes: {
        namePage: (context) {
          return screenHelp..args = ModalRoute.of(context)!.settings.arguments;
        },
      },
    ));

    return screenHelp;
  }

  @override
  Widget build(BuildContext context) {
    canPop = Navigator.canPop(context);
    return Scaffold(
      body: InkWell(
        key: _pageKey,
        onTap: () async {
          Navigator.pop(context, valuePop);
        },
      ),
    );
  }
}
