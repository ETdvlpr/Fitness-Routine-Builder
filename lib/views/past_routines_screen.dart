import 'package:fitness_routine_builder/controllers/routine_controller.dart';
import 'package:fitness_routine_builder/widgets/routine_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import the intl package

class PastRoutinesScreen extends StatelessWidget {
  final RoutineController pastRoutinesController = Get.put(RoutineController());

  PastRoutinesScreen({super.key});

  Future<void> _refreshData() async {
    await pastRoutinesController.loadSampleRoutines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Routines'),
        centerTitle: true,
      ),
      body: Obx(() => RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: pastRoutinesController.pastRoutines.length,
              itemBuilder: (context, index) {
                final routine = pastRoutinesController.pastRoutines[index];
                String formattedDate = DateFormat('MMMM dd, yyyy')
                    .format(routine.date.toLocal()); // Format date

                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(routine.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle:
                        Text('Date: $formattedDate'), // Display formatted date
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
          )),
    );
  }
}
