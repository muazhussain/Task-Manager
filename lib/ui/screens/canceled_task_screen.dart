import 'package:flutter/material.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/ui/widgets/task_list_item.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
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
            type: 'Canceled',
            onDeletePress: () {},
            onEditPress: () {},
          );
        },
      ),
    );
  }
}
