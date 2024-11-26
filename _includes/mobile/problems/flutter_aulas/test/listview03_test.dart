import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aulas/listview03.dart';

void main() {
  testWidgets('ListView displays all items', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: MyApp(), overrides: [
      itensProvider.overrideWith((Ref ref) async {
        await Future.delayed(Duration(seconds: 1));
        return ['banana', 'kiwi'];
      })
    ]));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('banana'), findsNothing);
    expect(find.text('Item 1'), findsNothing);

    await Duration(seconds: 1, milliseconds: 500);
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('banana'), findsOneWidget);
    expect(find.text('Item 1'), findsNothing);
  });

  test('Some description', () async {
    final container = createContainer();

    await expectLater(
      container.read(itensProvider.future),
      completion(['Item 1', 'Item 2', 'Item 3']),
    );
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
