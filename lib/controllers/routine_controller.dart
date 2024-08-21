
import 'package:fitness_routine_builder/models/sample_data.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/move.dart';
import '../models/routine.dart';

class RoutineController extends GetxController {
  var pastRoutines = <Routine>[].obs;
  get recentRoutines => pastRoutines.take(3).toList();
  var selectedMoves = <Move>[].obs;
  var routineName = ''.obs;
  var allMoves = <Move>[].obs;
  var filteredMoves = <Move>[].obs;
  var selectedMuscleGroup = ''.obs;
  var pageIndex = 0.obs;

  get muscleGroups =>
      ['All', ...allMoves.map((move) => move.muscleGroup).toSet()];

  @override
  void onInit() {
    super.onInit();
    loadSampleRoutines();
    loadSampleMoves();
  }

  Future<void> loadSampleRoutines() async {
    // Load routines from GetStorage; if empty, assign sample routines
    GetStorage box = GetStorage();
    if (box.read('routines') == null) {
      pastRoutines.value = sampleRoutines;
      box.write('routines', sampleRoutines);
    } else {
      pastRoutines.assignAll(List<Routine>.from(
          box.read('routines').map((routine) => Routine.fromJson(routine))));
    }

    // Sort routines by date
    pastRoutines.sort((a, b) => b.date.compareTo(a.date));
  }

  void loadSampleMoves() {
    // Load moves from GetStorage; if empty, assign sample moves
    GetStorage box = GetStorage();
    if (box.read('moves') == null) {
      box.write('moves', sampleMoves.map((move) => move.toJson()).toList());
    }
    allMoves.assignAll(
        List<Move>.from(box.read('moves').map((move) => Move.fromJson(move))));
    filteredMoves.assignAll(allMoves); // Initialize filtered moves
  }

  void addMove(Move move) {
    if (!selectedMoves.contains(move)) {
      selectedMoves.add(move);
    }
  }

  void removeMove(Move move) {
    selectedMoves.remove(move);
  }

  void filterMoves(String muscleGroup) {
    if (muscleGroup == 'All' || muscleGroup.isEmpty) {
      filteredMoves.assignAll(allMoves);
    } else {
      filteredMoves.assignAll(
          allMoves.where((move) => move.muscleGroup == muscleGroup).toList());
    }
    selectedMuscleGroup.value = muscleGroup;
  }

  void saveRoutine() {
    if (routineName.value.isEmpty || selectedMoves.isEmpty) {
      Get.snackbar('Validation Error',
          'Please enter a routine name and select at least one move.');
      return;
    }

    final Routine routine = Routine(
      name: routineName.value,
      moves: selectedMoves.toList(),
      date: DateTime.now(),
    );
    GetStorage box = GetStorage();
    List<Routine> routines = List<Routine>.from((box.read('routines') ?? [])
        ?.map((routine) => Routine.fromJson(routine)));
    routines.add(routine);
    box.write('routines', routines.map((routine) => routine.toJson()).toList());

    selectedMoves.clear();
    routineName.value = '';

    loadSampleRoutines();
    pageIndex.value = 2;
  }

  void deleteRoutine(Routine routine) {
    GetStorage box = GetStorage();
    List<Routine> routines = List<Routine>.from(
        (box.read('routines') ?? [])?.map((r) => Routine.fromJson(r)));
    routines
        .removeWhere((r) => r.name == routine.name && r.date == routine.date);
    box.write('routines', routines.map((r) => r.toJson()).toList());

    loadSampleRoutines();
  }

  // void editRoutine(Routine routine) {
  //   selectedMoves.assignAll(routine.moves);
  //   routineName.value = routine.name;
  //   pageIndex.value = 1;
  // }
}
