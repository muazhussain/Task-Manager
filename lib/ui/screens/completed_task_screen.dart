import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/Models/task_model.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/data/Models/task_update_model.dart';
import 'package:task_manager/ui/widgets/task_list_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  TaskModel completedTaskModel = TaskModel();
  bool _inProcess = false;
  Future<void> getAllCompletedTasks() async {
    _inProcess = true;
    setState(() {});
    final response = await NetworkUtils().getMethod(
      Urls.completedTaskUrl,
    );
    if (response != null) {
      completedTaskModel = TaskModel.fromJson(response);
    } else {
      showSnackbarMessage(
        context,
        'Unable to fetch data',
        true,
      );
    }
    _inProcess = false;
    setState(() {});
  }

  @override
  void initState() {
    getAllCompletedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
      child: _inProcess
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.yellow,
                valueColor: AlwaysStoppedAnimation(
                  Colors.green,
                ),
                strokeWidth: 5,
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                getAllCompletedTasks();
              },
              child: ListView.builder(
                itemCount: completedTaskModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskListItem(
                    subject: completedTaskModel.data?[index].title ?? 'Unknown',
                    description: completedTaskModel.data?[index].description ??
                        'Unknown',
                    date: completedTaskModel.data?[index].createdDate ??
                        'Unknown',
                    type: 'Completed',
                    onEditPress: () {
                      TaskUpdate.showChangeTaskStatus(
                        'Completed',
                        completedTaskModel.data?[index].sId ?? '',
                        () {
                          getAllCompletedTasks();
                        },
                      );
                    },
                    onDeletePress: () async {
                      await TaskUpdate.deleteTask(
                        completedTaskModel.data?[index].sId ?? '',
                      );
                      getAllCompletedTasks();
                    },
                  );
                },
              ),
            ),
    );
  }
}
