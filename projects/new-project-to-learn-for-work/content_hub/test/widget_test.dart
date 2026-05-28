import 'package:flutter_test/flutter_test.dart';

import 'package:content_hub/main.dart';

void main() {
  testWidgets('ContentHubApp renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ContentHubApp());

    expect(find.byType(ContentHubApp), findsOneWidget);
  });
}
