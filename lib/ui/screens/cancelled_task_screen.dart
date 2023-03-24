import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/Models/task_model.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/data/Models/task_update_model.dart';
import 'package:task_manager/ui/widgets/task_list_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  TaskModel cancelledTaskModel = TaskModel();
  bool _inProcess = false;

  Future<void> getAllCancelledTasks() async {
    _inProcess = true;
    setState(() {});
    final response = await NetworkUtils().getMethod(
      Urls.cancelledTaskUrl,
    );
    if (response != null) {
      cancelledTaskModel = TaskModel.fromJson(response);
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
    getAllCancelledTasks();
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
                getAllCancelledTasks();
              },
              child: ListView.builder(
                itemCount: cancelledTaskModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskListItem(
                    subject: cancelledTaskModel.data?[index].title ?? 'Unknown',
                    description: cancelledTaskModel.data?[index].description ??
                        'Unknown',
                    date: cancelledTaskModel.data?[index].createdDate ??
                        'Unknown',
                    type: 'Cancelled',
                    onEditPress: () async {
                      await TaskUpdate.showChangeTaskStatus(
                        'New',
                        cancelledTaskModel.data?[index].sId ?? '',
                        () {
                          getAllCancelledTasks();
                        },
                      );
                    },
                    onDeletePress: () async {
                      await TaskUpdate.deleteTask(
                        cancelledTaskModel.data?[index].sId ?? '',
                      );
                      getAllCancelledTasks();
                    },
                  );
                },
              ),
            ),
    );
  }
}
