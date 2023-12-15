import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_task_manager/ui/screens/progress_tasks_screen.dart';

import 'cancelled_tasks_screen.dart';
import 'completed_tasks_screen.dart';
import 'new_tasks_screen.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTasksScreen(),
    ProgressTasksScreen(),
    CompletedTasksScreen(),
    CancelledTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_list), label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.change_circle_outlined), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all_rounded), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),

        ],

      ),
    );
  }
}
