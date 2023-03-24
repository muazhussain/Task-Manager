import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/Models/task_model.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/data/Models/task_update_model.dart';
import 'package:task_manager/ui/widgets/task_list_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  TaskModel inProgressTaskModel = TaskModel();
  bool _inProcess = false;

  Future<void> getAllProgressTasks() async {
    _inProcess = true;
    setState(() {});
    final response = await NetworkUtils().getMethod(
      Urls.inProgressTaskUrl,
    );
    if (response != null) {
      inProgressTaskModel = TaskModel.fromJson(response);
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
    getAllProgressTasks();
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
                getAllProgressTasks();
              },
              child: ListView.builder(
                itemCount: inProgressTaskModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskListItem(
                    subject:
                        inProgressTaskModel.data?[index].title ?? 'Unknown',
                    description: inProgressTaskModel.data?[index].description ??
                        'Unknown',
                    date: inProgressTaskModel.data?[index].createdDate ??
                        'Unknown',
                    type: 'Progress',
                    onEditPress: () {
                      TaskUpdate.showChangeTaskStatus(
                        'Progress',
                        inProgressTaskModel.data?[index].sId ?? '',
                        () {
                          getAllProgressTasks();
                        },
                      );
                    },
                    onDeletePress: () async {
                      await TaskUpdate.deleteTask(
                        inProgressTaskModel.data?[index].sId ?? '',
                      );
                      getAllProgressTasks();
                    },
                  );
                },
              ),
            ),
    );
  }
}
