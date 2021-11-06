import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/features/authentication/login_screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.topRight,
      // color: Colors.grey,
      onPressed: () {
        AppInformationDao().deleteLoggedInUser().then((value) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (_) => false,
          );
        });
      },
      icon: const Icon(
        Icons.logout,
        size: 29,
      ),
    );
  }
}
