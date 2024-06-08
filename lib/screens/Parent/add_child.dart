import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player1/constants/constants.dart';
import 'package:video_player1/screens/Parent/My_cilds.dart';

class Add_child extends StatefulWidget {
  const Add_child({Key? key}) : super(key: key);

  @override
  State<Add_child> createState() => _Add_childState();
}

final _formSignInKey = GlobalKey<FormState>();

var nameC = TextEditingController();
var emailC = TextEditingController();
var passwordC = TextEditingController();
var ageC = TextEditingController();
final storage = FirebaseStorage.instance;
dynamic b;
dynamic x;

class _Add_childState extends State<Add_child> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formSignInKey,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Welcome\n" + UserName!,
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Add your Children Now !",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  controller: nameC,
                                  decoration: InputDecoration(
                                      hintText: "Child Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  controller: emailC,
                                  decoration: InputDecoration(
                                      hintText: "Child Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  controller: passwordC,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  controller: ageC,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "Age",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (_formSignInKey.currentState!.validate()) {
                              String email = emailC.text;
                              String name = nameC.text;
                              String age = ageC.text;
                              String password = passwordC.text;
                              if (email != "" &&
                                  password != "" &&
                                  age != "" &&
                                  name != "") {
                                FirebaseFirestore.instance
                                    .collection("Child")
                                    .add(<String, dynamic>{
                                  "Email": email,
                                  "Name": name,
                                  "Age": age,
                                  "Password": password,
                                  "Parent": UserName,
                                });
                                FirebaseFirestore.instance
                                    .collection("Course1")
                                    .add(<String, dynamic>{
                                  "V1": "false",
                                  "Name": name,
                                  "V2": "false",
                                  "V3": "false",
                                  "V4": "false",
                                  "V5": "false",
                                  "V6": "false",
                                  "V7": "false",
                                  "V8": "false",
                                  "V9": "false",
                                  "V10": "false",
                                });
                                FirebaseFirestore.instance
                                    .collection("Course2")
                                    .add(<String, dynamic>{
                                  "V1": "false",
                                  "Name": name,
                                  "V2": "false",
                                  "V3": "false",
                                  "V4": "false",
                                  "V5": "false",
                                  "V6": "false",
                                  "V7": "false",
                                  "V8": "false",
                                });
                                FirebaseFirestore.instance
                                    .collection("Course3")
                                    .add(<String, dynamic>{
                                  "V1": "false",
                                  "Name": name,
                                  "V2": "false",
                                  "V3": "false",
                                  "V4": "false",
                                });
                                FirebaseFirestore.instance
                                    .collection("Course4")
                                    .add(<String, dynamic>{
                                  "V1": "false",
                                  "Name": name,
                                  "V2": "false",
                                  "V3": "false",
                                  "V4": "false",
                                });
                                FirebaseFirestore.instance
                                    .collection("Points")
                                    .add(<String, dynamic>{
                                  "Points": "0",
                                  "Name": name,
                                });
                                await FirebaseFirestore.instance
                                    .collection("Progress")
                                    .doc(name)
                                    .collection("courses")
                                    .add(<String, dynamic>{
                                  "c1": "0",
                                  "c2": "0",
                                  "c3": "0",
                                  "c4": "0",
                                  "Name": name
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const My_Childs(),
                                  ),
                                );
                              }
                            }
                          },
                          height: 50,
                          // margin: EdgeInsets.symmetric(horizontal: 50),
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          // decoration: BoxDecoration(
                          // ),
                          child: Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
