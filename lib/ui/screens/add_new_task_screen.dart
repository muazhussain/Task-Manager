import 'package:flutter/material.dart';
import 'package:flutter_03/ui/widgets/app_elevated_button.dart';
import 'package:flutter_03/ui/widgets/app_text_form_field.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/ui/widgets/user_profile_widget.dart';
import 'package:flutter_03/utils/text_styles.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileWidget(),
            Expanded(
              child: ScreenBackground(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Text('Update Profile', style: screenTitleTextStyle),
                        const SizedBox(
                          height: 16,
                        ),
                        AppTextFieldWidget(
                          hintText: 'Subject',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        AppTextFieldWidget(
                          hintText: 'Description',
                          controller: TextEditingController(),
                          maxLines: 5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppElevatedButton(
                          child: const Icon(Icons.arrow_circle_right_outlined),
                          onPressed: () {},
                        ),
                      ],
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
