import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player1/screens/WelcomeScreen.dart';
import 'package:video_player1/screens/qr_code.dart';
import 'package:video_player1/screens/tiles.dart';

import '../constants/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QRScreen()));
                },
                child: SettingsTile(
                  color: Colors.black,
                  icon: Ionicons.qr_code,
                  title: "Redeem points",
                  onTap: () {

                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SettingsTile(
                color: Colors.orange,
                icon: Ionicons.person,
                title: "Name: " + UserName!,
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              SettingsTile(
                color: Colors.orange,
                icon: Ionicons.mail,
                title: "Email: " + userEmail!,
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              SettingsTile(
                color: Colors.orange,
                icon: Ionicons.calendar_number,
                title: "Age: " + Age!+" years",
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
                child: SettingsTile(
                  color: Colors.orange,
                  icon: Ionicons.log_out,
                  title: "Logout",
                  onTap: () {},
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
