// Para rodar estes testes, adicione mocktail ao seu pubspec.yaml:
// dev_dependencies:
//   mocktail: ^1.0.4

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentail/presentation/bloc/car_bloc.dart';
import 'package:rentail/presentation/bloc/car_state.dart';
import 'package:rentail/presentation/pages/car_list_screen.dart';
import 'package:rentail/data/models/car.dart';

class MockCarBloc extends Mock implements CarBloc {}

void main() {
  late MockCarBloc carBloc;

  setUp(() {
    carBloc = MockCarBloc();
    // Ensure the stream is stubbed to avoid null issues
    when(() => carBloc.stream).thenAnswer((_) => Stream<CarState>.empty());
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<CarBloc>.value(
        value: carBloc,
        child: child,
      ),
    );
  }

  testWidgets('shows loading indicator when state is CarsLoading', (WidgetTester tester) async {
    // Stub the state
    when(() => carBloc.state).thenReturn(CarsLoading());
    // Stub the stream for whenListen
    when(() => carBloc.stream).thenAnswer((_) => Stream<CarState>.fromIterable([CarsLoading()]));

    await tester.pumpWidget(makeTestableWidget(CarListScreen()));
    await tester.pump(); // Pump to process the stream
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows list of cars when state is CarsLoaded', (WidgetTester tester) async {
    final cars = [
      Car(model: 'Test Car', distance: 100, fuelCapacity: 50, pricePerHour: 10),
    ];
    // Stub the state
    when(() => carBloc.state).thenReturn(CarsLoaded(cars));
    // Stub the stream for whenListen
    when(() => carBloc.stream).thenAnswer((_) => Stream<CarState>.fromIterable([CarsLoaded(cars)]));

    await tester.pumpWidget(makeTestableWidget(CarListScreen()));
    await tester.pump(); // Pump to process the stream
    expect(find.text('Test Car'), findsOneWidget);
  });

  testWidgets('shows error message when state is CarsError', (WidgetTester tester) async {
    // Stub the state
    when(() => carBloc.state).thenReturn(CarsError('error'));
    // Stub the stream for whenListen
    when(() => carBloc.stream).thenAnswer((_) => Stream<CarState>.fromIterable([CarsError('error')]));

    await tester.pumpWidget(makeTestableWidget(CarListScreen()));
    await tester.pump(); // Pump to process the stream
    expect(find.textContaining('Error'), findsOneWidget);
  });
}