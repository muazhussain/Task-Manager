import 'package:flutter/material.dart';
import 'package:flutter_03/ui/widgets/app_elevated_button.dart';
import 'package:flutter_03/ui/widgets/app_text_form_field.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/ui/widgets/user_profile_widget.dart';
import 'package:flutter_03/utils/text_styles.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
                        InkWell(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                child: const Text('Photo'),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: const Text(''),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppTextFieldWidget(
                          hintText: 'Email',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        AppTextFieldWidget(
                          hintText: 'First name',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        AppTextFieldWidget(
                          hintText: 'Subject',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        AppTextFieldWidget(
                          hintText: 'Last name',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        AppTextFieldWidget(
                          hintText: 'Mobile number',
                          controller: TextEditingController(),
                        ),
                        AppTextFieldWidget(
                          hintText: 'Password',
                          controller: TextEditingController(),
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 8,
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
