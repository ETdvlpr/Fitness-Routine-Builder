import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_routine_builder/controllers/routine_controller.dart';
import 'package:fitness_routine_builder/models/routine.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class RoutineDetailScreen extends StatelessWidget {
  final Routine routine;

  const RoutineDetailScreen({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    final RoutineController routineController = Get.find<RoutineController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(routine.name),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.edit),
          //   onPressed: () {
          //     routineController.editRoutine(routine);
          //     Get.back();
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Show a confirmation dialog before deleting
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Routine'),
                  content:
                      const Text('Are you sure you want to delete this routine?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        routineController.deleteRoutine(routine);
                        Get.back(); // Close the dialog
                        Get.back(); // Navigate back to past routines list
                      },
                      child: const Text('Delete'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back(); // Close the dialog
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Routine Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
                'Date: ${DateFormat('MMMM dd, yyyy').format(routine.date.toLocal())}'),
            const SizedBox(height: 20),
            const Text('Moves:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: routine.moves.length,
                itemBuilder: (context, index) {
                  final move = routine.moves[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: move.imageUrl,
                        width: 50,
                        height: 50,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      title: Text(move.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          '${move.muscleGroup} - Spring Load: ${move.springLoad}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
