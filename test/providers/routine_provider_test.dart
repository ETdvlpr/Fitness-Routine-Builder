import 'package:fitness_routine_builder/repositories/routine_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_routine_builder/models/move.dart';
import 'package:fitness_routine_builder/models/routine.dart';
import 'package:fitness_routine_builder/providers/routine_provider.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('RoutineProvider', () {
    late RoutineProvider routineProvider;

    setUp(() {
      routineProvider = RoutineProvider(RoutineRepository());
    });

    test('should initialize with an empty list of routines', () {
      expect(routineProvider.routines.isEmpty, true);
    });

    test('should set routine name', () {
      routineProvider.setRoutineName('Test Routine');
      expect(routineProvider.routineName, 'Test Routine');
    });

    test('should add a move to selected moves', () {
      final move = Move(
          name: 'Push Up', muscleGroup: 'Chest', springLoad: 0, imageUrl: '');
      routineProvider.addMove(move);
      expect(routineProvider.selectedMoves.contains(move), true);
    });

    test('should remove a move from selected moves', () {
      final move = Move(
          name: 'Push Up', muscleGroup: 'Chest', springLoad: 0, imageUrl: '');
      routineProvider.addMove(move);
      routineProvider.removeMove(move);
      expect(routineProvider.selectedMoves.contains(move), false);
    });

    test('should filter moves by muscle group', () {
      final move1 = Move(
          name: 'Push Up', muscleGroup: 'Chest', springLoad: 0, imageUrl: '');
      final move2 =
          Move(name: 'Squat', muscleGroup: 'Legs', springLoad: 0, imageUrl: '');
      routineProvider.moves = [move1, move2];

      routineProvider.filterMoves('Legs');
      expect(routineProvider.filteredMoves, [move2]);
    });

    test('should save a routine with selected moves', () {
      final move = Move(
          name: 'Push Up', muscleGroup: 'Chest', springLoad: 0, imageUrl: '');
      routineProvider.addMove(move);
      routineProvider.setRoutineName('Morning Routine');

      routineProvider.saveRoutine();
      expect(routineProvider.routines.length, 1);
      expect(routineProvider.routines.first.name, 'Morning Routine');
      expect(routineProvider.routines.first.moves, [move]);
    });

    test('should delete a routine', () {
      final routine =
          Routine(name: 'Test Routine', moves: [], date: DateTime.now());
      routineProvider.routines.add(routine);

      routineProvider.deleteRoutine(routine);
      expect(routineProvider.routines.contains(routine), false);
    });
  });
}
