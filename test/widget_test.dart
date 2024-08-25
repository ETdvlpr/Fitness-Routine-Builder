import 'package:fitness_routine_builder/repositories/routine_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:fitness_routine_builder/models/routine.dart';
import 'package:fitness_routine_builder/widgets/routine_detail_screen.dart';
import 'package:fitness_routine_builder/providers/routine_provider.dart';

void main() {
  testWidgets('RoutineDetailScreen displays routine details',
      (WidgetTester tester) async {
    final routine =
        Routine(name: 'Morning Workout', moves: [], date: DateTime.now());

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => RoutineProvider(RoutineRepository()),
        child: MaterialApp(
          home: RoutineDetailScreen(routine: routine),
        ),
      ),
    );

    expect(find.text('Morning Workout'), findsOneWidget);
    expect(find.text('Routine Details'), findsOneWidget);
  });

  testWidgets('RoutineDetailScreen allows deleting a routine',
      (WidgetTester tester) async {
    final routineProvider = RoutineProvider(RoutineRepository());
    final routine =
        Routine(name: 'Morning Workout', moves: [], date: DateTime.now());
    routineProvider.routines.add(routine);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: routineProvider,
        child: MaterialApp(
          home: RoutineDetailScreen(routine: routine),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('Delete Routine'), findsOneWidget);

    await tester.tap(find.text('Delete'));
    await tester.pump();

    expect(routineProvider.routines.contains(routine), false);
  });
}
