import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:ripeto_flutter/component.dart';
import 'package:ripeto_flutter/screens/home_screen.dart';
import 'package:ripeto_flutter/screens/login_screen.dart';
import 'package:ripeto_flutter/screens/real_home_screen.dart';
import 'package:ripeto_flutter/screens/update_profile_screen.dart';
import 'package:ripeto_flutter/service/notification_api.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingsScreenHeader(),
            Divider(height: 0.0),
            Divider(height: 0.0),
            settingsOption(
              'Update Profile',
              () {
                pushNewScreen(
                  context,
                  screen: UpdateProfileScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
            Divider(height: 0.0),
            settingsOption(
              'Logout',
              () async {
                await _auth.signOut();
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                        LoginScreen.id, (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  InkWell settingsOption(String settingsName, Function onTap) {
    return InkWell(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(15.0),
        child: Text(
          settingsName,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  Padding settingsScreenHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            mainScreenTitle('Settings'),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
