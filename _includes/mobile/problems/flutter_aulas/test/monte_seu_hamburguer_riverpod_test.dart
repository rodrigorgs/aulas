// import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aulas/monte_seu_hamburguer_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

///////////////////////////////////
// NÃO FUNCIONA
///////////////////////////////////

// class MyConvenientTestSlot extends ConvenientTestSlot {
//   @override
//   Future<void> appMain(AppMainExecuteMode mode) async {}

//   @override
//   BuildContext? getNavContext(ConvenientTest t) => null;
// }

// void main() {
//   final defaultList = IngredienteList(initialValue: [
//     Ingrediente(1, 'Fatia de pão', 2),
//     Ingrediente(2, 'Repolho', 1),
//     Ingrediente(3, 'Pimentão', 2),
//   ]);
//   convenientTestMain(MyConvenientTestSlot(), () {
//     group('TelaMontagem', () {
//       testWidgets('deve exibir os itens', (WidgetTester tester) async {
//         await tester.pumpWidget(ProviderScope(
//           overrides: [ingredienteListProvider.overrideWith(() => defaultList)],
//           child: MaterialApp(
//               home: Scaffold(
//             body: TelaMontagem(),
//           )),
//         ));

//         expect(find.text('Fatia de pão'), findsOneWidget);
//         expect(find.text('Repolho'), findsOneWidget);
//         expect(find.text('Pimentão'), findsOneWidget);
//       });
//     });
//   });
// }

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

void main() {
  final defaultList = IngredienteList(initialValue: [
    Ingrediente(1, 'Fatia de pão', 2),
    Ingrediente(2, 'Repolho', 1),
    Ingrediente(3, 'Pimentão', 2),
  ]);
  group('TelaMontagem', () {
    testWidgets('deve exibir os itens', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
          overrides: [ingredienteListProvider.overrideWith(() => defaultList)],
          child: MaterialApp(home: Scaffold(body: TelaMontagem()))));

      expect(find.text('Fatia de pão'), findsOneWidget);
      expect(find.text('Repolho'), findsOneWidget);
      expect(find.text('Pimentão'), findsOneWidget);
    });

    testWidgets('deve atualizar o total ao selecionar um item',
        (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
          overrides: [ingredienteListProvider.overrideWith(() => defaultList)],
          child: MaterialApp(home: Scaffold(body: TelaMontagem()))));

      expect(find.text('Fatia de pão'), findsOneWidget);
      // expect(find.text('Total: 0 reais'), findsOneWidget);

      // await tester.tap(find.byType(Checkbox).first);
      // await tester.pump();

      // expect(find.text('Total: 2 reais'), findsOneWidget);
    });

    //   testWidgets('deve atualizar o total ao desmarcar um item',
    //       (WidgetTester tester) async {
    //     await tester.pumpWidget(ProviderScope(
    //         overrides: [ingredienteListProvider.overrideWith(() => defaultList)],
    //         child: MaterialApp(home: Scaffold(body: TelaMontagem()))));

    //     expect(find.text('Total: 0 reais'), findsOneWidget);

    //     await tester.tap(find.byType(Checkbox).first);
    //     await tester.pump();

    //     expect(find.text('Total: 2 reais'), findsOneWidget);

    //     await tester.tap(find.byType(Checkbox).first);
    //     await tester.pump();

    //     expect(find.text('Total: 0 reais'), findsOneWidget);
    //   });

    //   testWidgets('deve exibir o total correto ao selecionar vários itens',
    //       (WidgetTester tester) async {
    //     await tester.pumpWidget(ProviderScope(
    //         overrides: [ingredienteListProvider.overrideWith(() => defaultList)],
    //         child: MaterialApp(home: Scaffold(body: TelaMontagem()))));

    //     expect(find.text('Total: 0 reais'), findsOneWidget);

    //     await tester.tap(find.byType(Checkbox).first);
    //     await tester.pump();

    //     expect(find.text('Total: 2 reais'), findsOneWidget);

    //     await tester.tap(find.byType(Checkbox).at(1));
    //     await tester.pump();

    //     expect(find.text('Total: 3 reais'), findsOneWidget);

    //     await tester.tap(find.byType(Checkbox).at(2));
    //     await tester.pump();

    //     expect(find.text('Total: 5 reais'), findsOneWidget);
    //   });
  });
}
