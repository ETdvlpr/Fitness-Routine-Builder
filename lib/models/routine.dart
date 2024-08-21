import 'move.dart';

class Routine {
  final String name;
  final DateTime date;
  final List<Move> moves;

  Routine({required this.name, required this.date, required this.moves});

  // tojson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'moves': moves.map((move) => move.toJson()).toList(),
    };
  }

  // fromjson
  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      name: json['name'],
      date: DateTime.parse(json['date']),
      moves: List<Move>.from(
        json['moves'].map((move) => Move.fromJson(move)),
      ),
    );
  }
}
