import 'package:fitness_routine_builder/controllers/routine_controller.dart';
import 'package:fitness_routine_builder/widgets/routine_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  final RoutineController controller = Get.put(RoutineController());

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Routines'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.recentRoutines.length,
        itemBuilder: (context, index) {
          final routine = controller.recentRoutines[index];
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
                      builder: (context) =>
                          RoutineDetailScreen(routine: routine)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
