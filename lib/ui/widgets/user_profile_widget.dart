import 'package:flutter/material.dart';
import 'package:flutter_03/data/auth_utils.dart';
import 'package:flutter_03/ui/screens/login_screen.dart';
import 'package:flutter_03/ui/screens/update_profile_screen.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person_2_outlined)),
      title: Text('${AuthUtils.firstName ?? ' '} ${AuthUtils.lastName ?? ' '}'),
      subtitle: Text(AuthUtils.email ?? ' '),
      tileColor: Colors.green,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      trailing: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () async {
          await AuthUtils.clearData();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
      ),
    );
  }
}
