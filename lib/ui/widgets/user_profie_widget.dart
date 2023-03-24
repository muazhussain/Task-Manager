import 'package:flutter/material.dart';
import 'package:task_manager/data/auth_utils.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({super.key});

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  bool _inProcess = false;
  Future<void> logOut() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.yellow,
            valueColor: AlwaysStoppedAnimation(
              Colors.green,
            ),
            strokeWidth: 5,
          ),
        );
      },
    );
    await AuthUtils.clearData();
    Future.delayed(
      Duration(
        seconds: 1,
      ),
    ).then(
      (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _inProcess
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
              valueColor: AlwaysStoppedAnimation(
                Colors.green,
              ),
              strokeWidth: 5,
            ),
          )
        : ListTile(
            leading: const CircleAvatar(
              child: Icon(
                Icons.person_2_outlined,
              ),
            ),
            title: Text(
                '${AuthUtils.firstName ?? ' '} ${AuthUtils.lastName ?? ' '}'),
            subtitle: Text('${AuthUtils.email ?? 'Unknown'}'),
            tileColor: Colors.green,
            trailing: IconButton(
              icon: const Icon(
                Icons.login_outlined,
              ),
              onPressed: () async {
                logOut();
              },
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/updateProfile',
              );
            },
          );
  }
}
