import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/app_elevated_button.dart';
import 'package:task_manager/ui/widgets/app_text_field.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/user_profie_widget.dart';
import 'package:task_manager/utils/text_styles.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late final TextEditingController _emailETController;
  late final TextEditingController _firstNameETController;
  late final TextEditingController _lastNameETController;
  late final TextEditingController _mobileETController;
  late final TextEditingController _passwordETController;
  XFile? image;
  String? base64Image;
  late GlobalKey<FormState> _formKey;
  bool _inProcess = false;
  Map<String, String> bodyParams = {};

  @override
  void initState() {
    _emailETController = TextEditingController();
    _firstNameETController = TextEditingController();
    _lastNameETController = TextEditingController();
    _mobileETController = TextEditingController();
    _passwordETController = TextEditingController();
    _emailETController.text = AuthUtils.email ?? '';
    _firstNameETController.text = AuthUtils.firstName ?? '';
    _lastNameETController.text = AuthUtils.lastName ?? '';
    _mobileETController.text = AuthUtils.mobile ?? '';
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailETController.dispose();
    _firstNameETController.dispose();
    _lastNameETController.dispose();
    _mobileETController.dispose();
    _passwordETController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(
            'Select image from',
          ),
          actions: <Widget>[
            ListTile(
              title: Text('Camera'),
              leading: Icon(
                Icons.camera_outlined,
              ),
              onTap: () async {
                image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                Navigator.pop(context);
                if (image != null) {
                  setState(() {});
                }
              },
            ),
            ListTile(
              title: Text('Gallery'),
              leading: Icon(
                Icons.browse_gallery_outlined,
              ),
              onTap: () async {
                image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                Navigator.pop(context);
                if (image != null) {
                  setState(() {});
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> profileUpdate() async {
    _inProcess = true;
    setState(() {});
    if (image != null) {
      List<int> imageBytes = await image!.readAsBytes();
      print(imageBytes);
      base64Image = base64Encode(imageBytes);
    }
    if (_formKey.currentState!.validate()) {
      bodyParams = {
        'firstName': _firstNameETController.text.trim(),
        'lastName': _lastNameETController.text.trim(),
        'mobile': _mobileETController.text.trim(),
        'photo': base64Image ?? '',
      };
      final result = await NetworkUtils().postMethod(
        Urls.updateProfileUrl,
        body: bodyParams,
      );
      if (result != null && result['status'] == 'success') {
        print(result);
        await AuthUtils.saveUserData(
          AuthUtils.token!,
          AuthUtils.email!,
          _firstNameETController.text.trim(),
          _lastNameETController.text.trim(),
          _mobileETController.text.trim(),
          base64Image ?? '',
        );
        setState(() {});
        showSnackbarMessage(
          context,
          'Profile updated!',
        );
      } else {
        showSnackbarMessage(
          context,
          'Something went wrong! Try again!',
          true,
        );
      }
    }
    _inProcess = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _inProcess
            ? ScreenBackground(
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.green,
                    ),
                    strokeWidth: 5,
                  ),
                ),
              )
            : Column(
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
                                    'Update Profile',
                                    style: titleTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  InkWell(
                                    child: Row(
                                      children: <Widget>[
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
                                            child: Text(
                                              image?.name ?? '',
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      pickImage();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppTextFieldWidget(
                                    hintText: 'Email',
                                    controller: _emailETController,
                                    readOnly: true,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppTextFieldWidget(
                                    hintText: 'First name',
                                    controller: _firstNameETController,
                                    validator: (value) {
                                      final bool firstNameValid =
                                          RegExp('[a-zA-Z]')
                                              .hasMatch(value ?? '');
                                      if (firstNameValid) {
                                        return null;
                                      }
                                      return 'Enter valid first name';
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppTextFieldWidget(
                                    hintText: 'Last name',
                                    controller: _lastNameETController,
                                    validator: (value) {
                                      final bool lastNameValid =
                                          RegExp('[a-zA-Z]')
                                              .hasMatch(value ?? ' ');
                                      if (lastNameValid) {
                                        return null;
                                      }
                                      return 'Enter valid last name';
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppTextFieldWidget(
                                    hintText: 'Mobile',
                                    controller: _mobileETController,
                                    validator: (value) {
                                      final bool mobileValid =
                                          RegExp(r'(^(?:[+0]9)?[0-9]{6,12}$)')
                                              .hasMatch(value ?? '');
                                      if (mobileValid) {
                                        return null;
                                      }
                                      return 'Enter valid mobile number';
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppTextFieldWidget(
                                    hintText: 'Password',
                                    controller: _passwordETController,
                                    obscureText: true,
                                    validator: (value) {
                                      if (_passwordETController
                                          .text.isNotEmpty) {
                                        final bool passwordValid = RegExp(
                                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                                            .hasMatch(
                                          _passwordETController.text,
                                        );
                                        if (passwordValid) {
                                          bodyParams['password'] =
                                              _passwordETController.text;
                                          return null;
                                        } else {
                                          return 'Enter valid password';
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppElevatedButton(
                                    child: const Icon(
                                      Icons.arrow_circle_right_outlined,
                                    ),
                                    onPressed: profileUpdate,
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
