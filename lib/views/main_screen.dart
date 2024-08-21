import 'package:fitness_routine_builder/controllers/routine_controller.dart';
import 'package:fitness_routine_builder/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'new_routine_screen.dart';
import 'past_routines_screen.dart';

class MainScreen extends StatelessWidget {
  final RoutineController controller = Get.put(RoutineController());
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.pageIndex.value,
          children: [
            HomeScreen(),
            NewRoutineScreen(),
            PastRoutinesScreen(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.blueAccent,
        height: 60,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.fitness_center, size: 30, color: Colors.white),
          Icon(Icons.history, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          controller.pageIndex.value = index;
        },
      ),
    );
  }
}
