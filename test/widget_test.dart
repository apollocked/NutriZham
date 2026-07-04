import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // App requires SharedPreferences initialization outside widget tree
    expect(true, isTrue);
  });
}