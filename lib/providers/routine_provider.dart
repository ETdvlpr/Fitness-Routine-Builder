import 'package:flutter/material.dart';
import '../models/move.dart';
import '../models/routine.dart';
import '../repositories/routine_repository.dart';

class RoutineProvider with ChangeNotifier {
  final RoutineRepository _repository;

  RoutineProvider(this._repository) {
    _init();
  }

  List<Routine> _routines = [];
  List<Move> _moves = [];
  final List<Move> _selectedMoves = [];
  List<Move> _filteredMoves = [];
  String _routineName = '';
  String _selectedMuscleGroup = '';
  int _pageIndex = 0;

  List<Routine> get routines => _routines;

  List<Move> get moves => _moves;
  set moves(List<Move> moves) {
    _moves = moves;
    _filteredMoves = List.from(_moves);
    notifyListeners();
  }

  List<Move> get selectedMoves => _selectedMoves;
  List<Move> get filteredMoves => _filteredMoves;
  String get routineName => _routineName;
  String get selectedMuscleGroup => _selectedMuscleGroup;
  int get pageIndex => _pageIndex;

  List<String> get muscleGroups =>
      ['All', ..._moves.map((move) => move.muscleGroup).toSet()];

  Future<void> _init() async {
    await Future.wait([loadRoutines(), loadMoves()]);
  }

  Future<void> loadRoutines() async {
    _routines = await _repository.getRoutines();
    _routines.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> loadMoves() async {
    _moves = await _repository.getMoves();
    _filteredMoves = List.from(_moves);
    notifyListeners();
  }

  void addMove(Move move) {
    if (!_selectedMoves.contains(move)) {
      _selectedMoves.add(move);
      notifyListeners();
    }
  }

  void removeMove(Move move) {
    if (_selectedMoves.remove(move)) {
      notifyListeners();
    }
  }

  void filterMoves(String muscleGroup) {
    _selectedMuscleGroup = muscleGroup;
    _filteredMoves = muscleGroup == 'All' || muscleGroup.isEmpty
        ? List.from(_moves)
        : _moves.where((move) => move.muscleGroup == muscleGroup).toList();
    notifyListeners();
  }

  void setRoutineName(String name) {
    if (name != _routineName) {
      _routineName = name;
      notifyListeners();
    }
  }

  Future<void> saveRoutine() async {
    if (_routineName.isEmpty || _selectedMoves.isEmpty) return;

    final routine = Routine(
      name: _routineName,
      moves: List.from(_selectedMoves),
      date: DateTime.now(),
    );

    await _repository.saveRoutine(routine);
    _selectedMoves.clear();
    _routineName = '';
    await loadRoutines();
    setPageIndex(2);
  }

  Future<void> deleteRoutine(Routine routine) async {
    await _repository.deleteRoutine(routine);
    await loadRoutines();
  }

  void setPageIndex(int index) {
    if (_pageIndex != index) {
      _pageIndex = index;
      notifyListeners();
    }
  }
}
