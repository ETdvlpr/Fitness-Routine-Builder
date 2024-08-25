import 'package:get_storage/get_storage.dart';
import '../models/move.dart';
import '../models/routine.dart';
import '../models/sample_data.dart';

class RoutineRepository {
  final GetStorage _box = GetStorage();

  Future<List<Routine>> getRoutines() async {
    var storedRoutines = _box.read('routines');
    if (storedRoutines == null) {
      _box.write('routines', sampleRoutines);
      return sampleRoutines;
    }
    return List<Routine>.from(
        storedRoutines.map((routine) => Routine.fromJson(routine)));
  }

  Future<List<Move>> getMoves() async {
    var storedMoves = _box.read('moves');
    if (storedMoves == null) {
      _box.write('moves', sampleMoves.map((move) => move.toJson()).toList());
      return sampleMoves;
    }
    return List<Move>.from(storedMoves.map((move) => Move.fromJson(move)));
  }

  Future<void> saveRoutine(Routine routine) async {
    List<Routine> routines = await getRoutines();
    routines.add(routine);
    _box.write(
        'routines', routines.map((routine) => routine.toJson()).toList());
  }

  Future<void> deleteRoutine(Routine routine) async {
    List<Routine> routines = await getRoutines();
    routines
        .removeWhere((r) => r.name == routine.name && r.date == routine.date);
    _box.write('routines', routines.map((r) => r.toJson()).toList());
  }
}
