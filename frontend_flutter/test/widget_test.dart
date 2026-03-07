import 'package:flutter_test/flutter_test.dart';

import 'package:drake_love_finder_front/main.dart';

void main() {
  testWidgets('App renders with main elements', (WidgetTester tester) async {
    await tester.pumpWidget(const DrakeLoveFinderApp());

    // Verify app title is present
    expect(find.text('Drake Equation Love Finder'), findsOneWidget);

    // Verify section headers
    expect(find.text('Your City'), findsOneWidget);
    expect(find.text('Your Factors'), findsOneWidget);
    expect(find.text('Your Results'), findsOneWidget);

    // Verify population input
    expect(find.text('City population'), findsOneWidget);

    // Verify all 6 factor labels
    expect(find.text('Demographic compatibility'), findsOneWidget);
    expect(find.text('Meeting opportunities'), findsOneWidget);
    expect(find.text('Emotional connection'), findsOneWidget);
    expect(find.text('Communication effectiveness'), findsOneWidget);
    expect(find.text('Long-term compatibility'), findsOneWidget);
    expect(find.text('Time frame'), findsOneWidget);
  });

  testWidgets('Result shows probability percentage',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DrakeLoveFinderApp());

    // Default probability should be around 1.6% (0.5^6 * 100)
    expect(find.textContaining('%'), findsWidgets);
  });
}
