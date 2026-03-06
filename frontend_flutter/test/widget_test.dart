import 'package:flutter_test/flutter_test.dart';

import 'package:drake_love_finder_front/main.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(const DrakeLoveFinderApp());
    expect(find.text('Drake Equation Love Finder'), findsOneWidget);
  });
}
