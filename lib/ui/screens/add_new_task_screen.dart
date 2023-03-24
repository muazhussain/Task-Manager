import 'package:flutter/material.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/app_elevated_button.dart';
import 'package:task_manager/ui/widgets/app_text_field.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/user_profie_widget.dart';
import 'package:task_manager/utils/text_styles.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  late final TextEditingController _subjectETController;
  late final TextEditingController _descriptionETController;
  late GlobalKey<FormState> _formKey;
  bool _inProcess = false;

  @override
  void initState() {
    _subjectETController = TextEditingController();
    _descriptionETController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _subjectETController.dispose();
    _descriptionETController.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _inProcess = true;
      setState(() {});
      final result = await NetworkUtils().postMethod(
        Urls.createNewTaskUrl,
        body: {
          "title": _subjectETController.text.trim(),
          "description": _descriptionETController.text.trim(),
          "status": "New",
        },
        onUnAuthorized: () async {
          await AuthUtils.clearData();
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        },
      );
      _inProcess = false;
      setState(() {});
      if (result != null && result['status'] == 'success') {
        _subjectETController.clear();
        _descriptionETController.clear();
        showSnackbarMessage(
          context,
          'Task Added!',
        );
      } else {
        showSnackbarMessage(
          context,
          'Something went wrong! Try again!',
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _inProcess
          ? Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) / 2,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.green,
                    ),
                    strokeWidth: 5,
                  ),
                ],
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  const UserProfileWidget(),
                  Expanded(
                    child: ScreenBackground(
                      child: SingleChildScrollView(
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 34,
                                  ),
                                  Text(
                                    'Add New Task',
                                    style: titleTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppTextFieldWidget(
                                    hintText: 'Subject',
                                    controller: _subjectETController,
                                    validator: (value) {
                                      final bool subjectValid =
                                          RegExp(r'\p{Letter}', unicode: true)
                                              .hasMatch(value ?? '');
                                      if (subjectValid) {
                                        return null;
                                      }
                                      return 'Enter valid task name';
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppTextFieldWidget(
                                    hintText: 'Description',
                                    controller: _descriptionETController,
                                    maxLines: 5,
                                    validator: (value) {
                                      final bool descriptionValid =
                                          RegExp(r'\p{Letter}', unicode: true)
                                              .hasMatch(value ?? '');
                                      if (descriptionValid) {
                                        return null;
                                      }
                                      return 'Enter valid description';
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppElevatedButton(
                                    child: const Icon(
                                      Icons.arrow_circle_right_outlined,
                                    ),
                                    onPressed: onSubmit,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
