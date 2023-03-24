import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/in_progress_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/widgets/user_profie_widget.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _currentTab = 0;
  final List<Widget> _screns = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    InProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SafeArea(
            child: UserProfileWidget(),
          ),
          Expanded(
            child: _screns[_currentTab],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.close_outlined),
            label: 'Cancelled',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.run_circle_outlined),
            label: 'Progress',
          ),
        ],
        elevation: 2,
        selectedItemColor: Colors.amberAccent,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.blueAccent,
        showUnselectedLabels: true,
        currentIndex: _currentTab,
        onTap: (value) {
          _currentTab = value;
          setState(() {});
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_outlined),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/addNewTask',
          );
        },
      ),
    );
  }
}
