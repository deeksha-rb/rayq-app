import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rayq/main.dart';

void main() {
  testWidgets('App loads without errors', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyAppRoot(isDarkMode: false), // Only pass isDarkMode
    ));

    expect(find.text('rayQ.ai'), findsOneWidget);
  });
}