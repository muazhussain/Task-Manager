import 'package:flutter/material.dart';
import 'package:flutter_03/ui/screens/add_new_task_screen.dart';
import 'package:flutter_03/ui/screens/canceled_task_screen.dart';
import 'package:flutter_03/ui/screens/completed_task_screen.dart';
import 'package:flutter_03/ui/screens/in_progress_task_screen.dart';
import 'package:flutter_03/ui/screens/new_task_screen.dart';
import 'package:flutter_03/ui/widgets/user_profile_widget.dart';

class MainBottonNavBar extends StatefulWidget {
  const MainBottonNavBar({super.key});

  @override
  State<MainBottonNavBar> createState() => _MainBottonNavBarState();
}

class _MainBottonNavBarState extends State<MainBottonNavBar> {
  int _currentTab = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    InProgressTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            child: UserProfileWidget(),
          ),
          Expanded(child: _screens[_currentTab]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTask(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          _currentTab = value;
          setState(() {});
        },
        selectedItemColor: Colors.amberAccent,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.blueAccent,
        showUnselectedLabels: true,
        currentIndex: _currentTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.new_label_outlined),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all_outlined),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close),
            label: 'Cancel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.run_circle_outlined),
            label: 'In Progress',
          ),
        ],
      ),
    );
  }
}
