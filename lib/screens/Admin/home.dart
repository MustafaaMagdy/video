import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player1/screens/Admin/edit.dart';

import '../../api/widget/button_widget.dart';

class Admin_Home extends StatefulWidget {
  const Admin_Home({Key? key}) : super(key: key);

  @override
  State<Admin_Home> createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {
  final storage = FirebaseStorage.instance;
  dynamic b;
  dynamic x;
  var courseC = TextEditingController();
  var descriptionC = TextEditingController();
  var id;
  late bool found;
  late var Course_ID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Add Courses"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: TextField(
                    controller: courseC,
                    decoration: InputDecoration(
                        hintText: "Course Name",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200))),
                  child: TextField(
                    controller: descriptionC,
                    decoration: InputDecoration(
                        hintText: "description",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                ButtonWidget(
                  text: 'Select File',
                  icon: Icons.camera_alt,
                  onClicked: getImageFromCamera,
                ),
                SizedBox(height: 8),
                ButtonWidget(
                  text: 'Select File',
                  icon: Icons.storage,
                  onClicked: getImageFromGallery,
                ),
                SizedBox(height: 8),
                ButtonWidget(
                  text: 'edit',
                  icon: Icons.storage,
                  onClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const edit(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 48),
                ButtonWidget(
                  text: 'Upload File',
                  icon: Icons.cloud_upload_outlined,
                  onClicked: () async {
                    if (b != null) {
                      //upload to firebase
                      String name = courseC.text;
                      String des = descriptionC.text;
                      var snapshot = await storage
                          .ref()
                          .child('folderName/${courseC.text}')
                          .putFile(x)
                          .whenComplete(() {});
                      var downloadUrl = await snapshot.ref.getDownloadURL();
                      var users =
                          FirebaseFirestore.instance.collection("Courses");
                      var userquerySnapshot = await users.get();
                      for (var userDocumentSnapshot in userquerySnapshot.docs) {
                        Map<String, dynamic> data = userDocumentSnapshot.data();
                        if (data["Name"].toString() == courseC.text) {
                          id = userDocumentSnapshot.id;
                          Course_ID = id.toString();
                          found = true;
                        }
                      }
                      if (found = true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Enter Valid Data'),
                          ),
                        );
                      } else {
                        FirebaseFirestore.instance
                            .collection("Courses")
                            .add(<String, dynamic>{"Des": des, "Name": name});
                      }

                      FirebaseFirestore.instance
                          .collection(name)
                          .add(<String, dynamic>{
                        "V1": downloadUrl,
                      });
                    }
                  },
                ),
                SizedBox(height: 48),
                ButtonWidget(
                  text: 'permission',
                  icon: Icons.cloud_upload_outlined,
                  onClicked: requestStoragePermission,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImageFromGallery() async {
    ImagePicker a = ImagePicker();

    b = await a.getVideo(source: ImageSource.gallery);
    setState(() {
      x = File(b.path);
    });
  }

  getImageFromCamera() async {
    ImagePicker a = ImagePicker();
    b = await a.getVideo(source: ImageSource.camera);

    setState(() {
      x = File(b.path);
    });
  }

  requestStoragePermission() async {
    await Permission.storage.request();
  }
}
