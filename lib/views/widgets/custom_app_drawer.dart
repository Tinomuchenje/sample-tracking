import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/views/authentication/login_screen.dart';

import 'custom_text_elevated_button.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: 50,
                width: 150,
                child: CustomElevatedButton(
                  displayText: "LOGOUT",
                  fillcolor: true,
                  press: () {
                    AppInformationDao().deleteLoggedInUser().then((value) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (_) => false,
                      );
                    });
                  },
                ))
          ],
        ),
      ),
    );
  }
}
