import 'package:flutter/material.dart';
import 'package:flutter_03/ui/widgets/dashboard_item_widget.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/ui/widgets/task_list_item.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: DashboardItemWidget(numberOfTask: 12, type: 'New'),
                ),
                Expanded(
                  child:
                      DashboardItemWidget(numberOfTask: 12, type: 'Completed'),
                ),
                Expanded(
                  child: DashboardItemWidget(numberOfTask: 12, type: 'Cancel'),
                ),
                Expanded(
                  child: DashboardItemWidget(
                      numberOfTask: 12, type: 'In Progress'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return TaskListItem(
                    subject: 'Title here',
                    description: 'Description here',
                    date: '12/12/12',
                    type: 'New',
                    onDeletePress: () {},
                    onEditPress: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
