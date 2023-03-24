import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/task_count.dart';
import 'package:task_manager/data/Models/task_model.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/dashboard_item_widget.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/data/Models/task_update_model.dart';
import 'package:task_manager/ui/widgets/task_list_item.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TaskModel newTaskModel = TaskModel();
  TaskCount taskCount = TaskCount();
  Map<String, int> taskCountData = Map();
  bool _inProcess = false;
  Future<void> getTasksData() async {
    _inProcess = true;
    setState(() {});
    final response1 = await NetworkUtils().getMethod(
      Urls.newTaskUrl,
    );
    final response2 = await NetworkUtils().getMethod(
      Urls.taskCountUrl,
    );
    if (response1 != null && response2 != null) {
      newTaskModel = TaskModel.fromJson(response1);
      taskCount = TaskCount.fromJson(response2);
      taskCount.data!.forEach(
        (element) {
          taskCountData[element.sId ?? ''] = element.sum ?? 0;
        },
      );
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
    getTasksData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
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
                  await getTasksData();
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: DashboardItemWidget(
                            numberOfTask: taskCountData['New'] ?? 0,
                            type: 'New',
                          ),
                        ),
                        Expanded(
                          child: DashboardItemWidget(
                            numberOfTask: taskCountData['Completed'] ?? 0,
                            type: 'Completed',
                          ),
                        ),
                        Expanded(
                          child: DashboardItemWidget(
                            numberOfTask: taskCountData['Cancelled'] ?? 0,
                            type: 'Cancelled',
                          ),
                        ),
                        Expanded(
                          child: DashboardItemWidget(
                            numberOfTask: taskCountData['Progress'] ?? 0,
                            type: 'Progress',
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: newTaskModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListItem(
                            subject:
                                newTaskModel.data?[index].title ?? 'Unknown',
                            description:
                                newTaskModel.data?[index].description ??
                                    'Unknown',
                            date: newTaskModel.data?[index].createdDate ??
                                'Unknown',
                            type: 'New',
                            onEditPress: () {
                              TaskUpdate.showChangeTaskStatus(
                                'New',
                                newTaskModel.data?[index].sId ?? '',
                                () {
                                  getTasksData();
                                },
                              );
                            },
                            onDeletePress: () {
                              TaskUpdate.deleteTask(
                                newTaskModel.data?[index].sId ?? '',
                              );
                              getTasksData();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
