import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/routine_provider.dart';
import '../widgets/routine_detail_screen.dart';

class PastRoutinesScreen extends StatelessWidget {
  const PastRoutinesScreen({super.key});

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<RoutineProvider>(context, listen: false).loadRoutines();
  }

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Routines'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        child: ListView.builder(
          itemCount: routineProvider.routines.length,
          itemBuilder: (context, index) {
            final routine = routineProvider.routines[index];
            String formattedDate =
                DateFormat('MMMM dd, yyyy').format(routine.date.toLocal());

            return Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: Text(routine.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Date: $formattedDate'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RoutineDetailScreen(routine: routine),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
