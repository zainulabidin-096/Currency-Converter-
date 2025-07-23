import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void main() {
  testWidgets('CurrencyConverterScreen renders correctly', (WidgetTester tester) async {
    // Build our app (no need for const)
    await tester.pumpWidget(MaterialApp(home: CurrencyConverterScreen ()));

    // Verify initial UI elements
    expect(find.text('Currency Converter'), findsOneWidget); // AppBar title
    expect(find.byType(TextField), findsOneWidget); // Amount input
    expect(find.byType(DropdownButton2<String>), findsNWidgets(2)); // Two dropdowns
  });

  testWidgets('Currency conversion works', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CurrencyConverterScreen ()));

    // Enter amount
    await tester.enterText(find.byType(TextField), '10');
    await tester.pump(); // Trigger rebuild

    // Verify conversion text appears (format: "10.00 USD = XXX.00 PKR")
    expect(find.textContaining('10.00 USD'), findsOneWidget);
    expect(find.textContaining('PKR'), findsOneWidget);
  });
}