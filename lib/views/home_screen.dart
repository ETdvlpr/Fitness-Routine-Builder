import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/routine_provider.dart';
import '../widgets/routine_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Routines'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: routineProvider.routines.length,
        itemBuilder: (context, index) {
          final routine = routineProvider.routines[index];
          return Card(
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title: Text(routine.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'Date: ${DateFormat('MMMM dd, yyyy').format(routine.date.toLocal())}\n'
                'Moves: ${routine.moves.length}\n'
                'Muscle Groups: ${routine.moves.map((move) => move.muscleGroup).toSet().join(', ')}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoutineDetailScreen(routine: routine),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
