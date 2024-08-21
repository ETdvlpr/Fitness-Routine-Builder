import 'move.dart';
import 'routine.dart';

final List<Move> sampleMoves = [
  Move(
      name: 'Chest Press',
      muscleGroup: 'Chest',
      springLoad: 3,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/9/93/Dumbbell-bench-press-2.png'),
  Move(
      name: 'Lat Pulldown',
      muscleGroup: 'Back',
      springLoad: 4,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/8/82/Wide-grip-lat-pull-down-1.gif'),
  Move(
      name: 'Bicep Curl',
      muscleGroup: 'Biceps',
      springLoad: 2,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/c/c6/Two-arm-preacher-curl-2.gif'),
  Move(
      name: 'Tricep Extension',
      muscleGroup: 'Triceps',
      springLoad: 3,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/c/c3/Standing-triceps-extension-2-2.gif'),
  Move(
      name: 'Leg Press',
      muscleGroup: 'Legs',
      springLoad: 5,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Leg-press-1-1024x670.png/800px-Leg-press-1-1024x670.png?20101103054156'),
  Move(
      name: 'Shoulder Press',
      muscleGroup: 'Shoulders',
      springLoad: 3,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/a/a3/Dumbbell-shoulder-press-2.png'),
  Move(
      name: 'Squats',
      muscleGroup: 'Legs',
      springLoad: 4,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Front-squat-1-857x1024.png/170px-Front-squat-1-857x1024.png'),
  Move(
      name: 'Deadlift',
      muscleGroup: 'Back',
      springLoad: 5,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Barbell_dead_lifts_2.svg/800px-Barbell_dead_lifts_2.svg.png'),
  Move(
      name: 'Bench Press',
      muscleGroup: 'Chest',
      springLoad: 4,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/6/65/Decline-bench-press-1.png'),
  Move(
      name: 'Lateral Raise',
      muscleGroup: 'Shoulders',
      springLoad: 2,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/f/fd/Dumbbell-lateral-raises-1.png'),
];

final List<Routine> sampleRoutines = [
  Routine(
    name: 'Full Body Workout',
    date: DateTime.now().subtract(const Duration(days: 1)),
    moves: [
      sampleMoves[0], // Chest Press
      sampleMoves[1], // Lat Pulldown
      sampleMoves[4], // Leg Press
    ],
  ),
  Routine(
    name: 'Upper Body Strength',
    date: DateTime.now().subtract(const Duration(days: 2)),
    moves: [
      sampleMoves[0], // Chest Press
      sampleMoves[2], // Bicep Curl
      sampleMoves[3], // Tricep Extension
      sampleMoves[5], // Shoulder Press
    ],
  ),
  Routine(
    name: 'Leg Day',
    date: DateTime.now().subtract(const Duration(days: 3)),
    moves: [
      sampleMoves[4], // Leg Press
      sampleMoves[6], // Squats
      sampleMoves[7], // Deadlift
    ],
  ),
  Routine(
    name: 'Push Day',
    date: DateTime.now().subtract(const Duration(days: 4)),
    moves: [
      sampleMoves[0], // Chest Press
      sampleMoves[5], // Shoulder Press
      sampleMoves[8], // Bench Press
    ],
  ),
  Routine(
    name: 'Pull Day',
    date: DateTime.now().subtract(const Duration(days: 5)),
    moves: [
      sampleMoves[1], // Lat Pulldown
      sampleMoves[2], // Bicep Curl
      sampleMoves[7], // Deadlift
    ],
  ),
];
