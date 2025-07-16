import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rentail/main.dart' as app;
import 'package:rentail/presentation/widgets/car_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Onboarding, loading, car list and tap on card', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 10));

    // Aguarda a tela de onboarding aparecer
    final letsGoButton = find.widgetWithText(ElevatedButton, "Let's Go");
    expect(letsGoButton, findsOneWidget);

    // Clica no botão "Let's Go"
    await tester.tap(letsGoButton);
    await tester.pump(); // inicia a transição
    await tester.pump(const Duration(milliseconds: 500)); // aguarda animação

    // Verifica se aparece o loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Aguarda o carregamento dos carros (pode ajustar o tempo se necessário)
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Verifica se os cards de carros aparecem
    final carCard = find.byType(CarCard);
    expect(carCard, findsWidgets);

    // Clica no primeiro card de carro
    await tester.tap(carCard.first);
    await tester.pumpAndSettle();

    // Aqui você pode adicionar asserts para verificar se a tela de detalhes foi aberta, por exemplo:
    // expect(find.text('Detalhes do Carro'), findsOneWidget);
  });
}