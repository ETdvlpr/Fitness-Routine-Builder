import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_routine_builder/controllers/routine_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewRoutineScreen extends StatelessWidget {
  final RoutineController routineController = Get.put(RoutineController());

  NewRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Routine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Routine Name'),
              onChanged: (value) {
                routineController.routineName.value = value;
              },
            ),
            const SizedBox(height: 20),
            //selected moves
            Obx(
              () => Wrap(
                spacing: 8,
                children: routineController.selectedMoves
                    .map((move) => Chip(
                          label: Text(move.name),
                          onDeleted: () {
                            routineController.removeMove(move);
                          },
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => DropdownButton<String>(
                  value: routineController.selectedMuscleGroup.value.isEmpty
                      ? null
                      : routineController.selectedMuscleGroup.value,
                  hint: const Text('Select Muscle Group'),
                  isExpanded: true,
                  onChanged: (newValue) {
                    routineController.filterMoves(newValue!);
                  },
                  items: routineController.muscleGroups
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: routineController.filteredMoves.length,
                    itemBuilder: (context, index) {
                      final move = routineController.filteredMoves[index];
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
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          title: Text(
                            move.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '${move.muscleGroup} - Spring Load: ${move.springLoad}'),
                          trailing: Obx(() => IconButton(
                                icon: Icon(
                                  routineController.selectedMoves.contains(move)
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                ),
                                onPressed: () {
                                  if (routineController.selectedMoves
                                      .contains(move)) {
                                    routineController.removeMove(move);
                                  } else {
                                    routineController.addMove(move);
                                  }
                                },
                              )),
                        ),
                      );
                    },
                  )),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                routineController.saveRoutine();
              },
              child: const Text('Save Routine'),
            ),
          ],
        ),
      ),
    );
  }
}
