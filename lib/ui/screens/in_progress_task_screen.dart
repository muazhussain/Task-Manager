import 'package:flutter/material.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/ui/widgets/task_list_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
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
            type: 'In Progress',
            onDeletePress: () {},
            onEditPress: () {},
          );
        },
      ),
    );
  }
}
