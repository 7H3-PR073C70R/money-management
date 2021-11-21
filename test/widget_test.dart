// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:money_management/constants/enums.dart';
import 'package:money_management/ui/views/main/change_currency/change_currency_view_mode.dart';

void main() {
    group('ChangeCurrencyViewModel()', () { 
    group('setSelectedCurrency', () {
      test('When setSelectedCurrency is called, selectedCurrency should equal to the currency passed ', () {
        var model = ChangeCurrencyViewModel();
        model.setSelectedCurrency(Currencies.euro);
        expect(model.selectedCurrency, Currencies.euro);
      });

      test('When setDefaultCurrency is called, selectedCurrency to equal Currencies.ngn', () {
        var model = ChangeCurrencyViewModel();
        model.setDefaultCurrency();
        expect(model.selectedCurrency, Currencies.ngn);
      });
     });
  });
}
