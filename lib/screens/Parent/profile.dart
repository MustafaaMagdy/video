import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player1/screens/qr_code.dart';
import 'package:video_player1/screens/tiles.dart';
import '../../constants/constants.dart';
import '../WelcomeScreen.dart';

class Parent_Profile extends StatefulWidget {
  const Parent_Profile({Key? key}) : super(key: key);

  @override
  State<Parent_Profile> createState() => _Parent_ProfileState();
}

class _Parent_ProfileState extends State<Parent_Profile> {
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
                title: "Password: " + Password!,
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
