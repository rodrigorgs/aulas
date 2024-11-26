import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aulas/listview04.dart';

void main() {
  testWidgets('ListView displays all items', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MyApp(),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('banana'), findsNothing);
    expect(find.text('Item 1'), findsNothing);

    await Duration(seconds: 1, milliseconds: 500);
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('banana'), findsNothing);
    expect(find.text('Item 1'), findsOneWidget);
  });
}

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}
