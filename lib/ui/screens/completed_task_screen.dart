import 'package:flutter/material.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/ui/widgets/task_list_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) {
          return TaskListItem(
            subject: 'Title here',
            description: 'Description here',
            date: '12/12/12',
            type: 'Completed',
            onDeletePress: () {},
            onEditPress: () {},
          );
        },
      ),
    );
  }
}
