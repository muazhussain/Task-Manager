import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/ui/widgets/app_elevated_button.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';

class TaskUpdate {
  static Future<void> showChangeTaskStatus(String currentStatus, String taskId,
      VoidCallback onTaskChangeCompleted) async {
    showModalBottomSheet(
      context: TaskManagerApp.globalKey.currentContext!,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, changeState) {
            return Column(
              children: <Widget>[
                RadioListTile(
                  value: 'New',
                  title: const Text('New'),
                  groupValue: currentStatus,
                  onChanged: (state) {
                    currentStatus = state!;
                    changeState(
                      () {},
                    );
                  },
                ),
                RadioListTile(
                  value: 'Completed',
                  title: const Text('Completed'),
                  groupValue: currentStatus,
                  onChanged: (state) {
                    currentStatus = state!;
                    changeState(
                      () {},
                    );
                  },
                ),
                RadioListTile(
                  value: 'Cancelled',
                  title: const Text('Cancelled'),
                  groupValue: currentStatus,
                  onChanged: (state) {
                    currentStatus = state!;
                    changeState(
                      () {},
                    );
                  },
                ),
                RadioListTile(
                  value: 'Progress',
                  title: const Text('Progress'),
                  groupValue: currentStatus,
                  onChanged: (state) {
                    currentStatus = state!;
                    changeState(
                      () {},
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppElevatedButton(
                    child: const Text('Change Status'),
                    onPressed: () async {
                      final response = await NetworkUtils().getMethod(
                        Urls.changeTaskStatus(
                          taskId,
                          currentStatus,
                        ),
                      );
                      Future.delayed(
                        Duration(
                          seconds: 2,
                        ),
                      ).then(
                        (value) {
                          if (response != null) {
                            onTaskChangeCompleted();
                            Navigator.pop(context);
                          } else {
                            showSnackbarMessage(
                              context,
                              'Status change failed! Try again!',
                              true,
                            );
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  static Future<void> deleteTask(String taskId) async {
    final result = await NetworkUtils().getMethod(
      Urls.deleteTaskUrl(taskId),
    );
    if (result != null) {
      showSnackbarMessage(
        TaskManagerApp.globalKey.currentContext!,
        'Task deleted!',
      );
    } else {
      showSnackbarMessage(
        TaskManagerApp.globalKey.currentContext!,
        'Something went wrong! Try again!',
        true,
      );
    }
  }
}
