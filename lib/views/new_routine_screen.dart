import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../providers/routine_provider.dart';

class NewRoutineScreen extends StatelessWidget {
  const NewRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context);

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
                routineProvider.setRoutineName(value);
              },
            ),
            const SizedBox(height: 20),
            // Selected moves
            Wrap(
              spacing: 8,
              children: routineProvider.selectedMoves
                  .map((move) => Chip(
                        label: Text(move.name),
                        onDeleted: () {
                          routineProvider.removeMove(move);
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: routineProvider.selectedMuscleGroup.isEmpty
                  ? null
                  : routineProvider.selectedMuscleGroup,
              hint: const Text('Select Muscle Group'),
              isExpanded: true,
              onChanged: (newValue) {
                routineProvider.filterMoves(newValue!);
              },
              items: routineProvider.muscleGroups
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: routineProvider.filteredMoves.length,
                itemBuilder: (context, index) {
                  final move = routineProvider.filteredMoves[index];
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
                      title: Text(move.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          '${move.muscleGroup} - Spring Load: ${move.springLoad}'),
                      trailing: IconButton(
                        icon: Icon(
                          routineProvider.selectedMoves.contains(move)
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        onPressed: () {
                          if (routineProvider.selectedMoves.contains(move)) {
                            routineProvider.removeMove(move);
                          } else {
                            routineProvider.addMove(move);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                routineProvider.saveRoutine();
              },
              child: const Text('Save Routine'),
            ),
          ],
        ),
      ),
    );
  }
}
