import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';

class Child_screen extends StatefulWidget {
  final String name;
  final String email;
  final double progress;
  final String age;

  const Child_screen({
    Key? key,
    required this.name,
    required this.email,
    required this.progress,
    required this.age,
  }) : super(key: key);

  @override
  State<Child_screen> createState() => _Child_screenState();
}

class _Child_screenState extends State<Child_screen> {
  var id;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection("Progress")
        .doc(widget.name)
        .collection("courses")
        .get();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "BabySitter's Profile ",
        ),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Progress")
            .doc(widget.name)
            .collection("courses")
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return const Text(
              "Loading !",
              style: TextStyle(fontSize: 40),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data.docs.length,
              separatorBuilder: (context, i) {
                return const Divider(
                  color: Colors.grey,
                  endIndent: 20,
                  indent: 20,
                  thickness: 1,
                );
              },
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNMLXMlOfq_uOypUzMeQ8rHpFmrlyF6pLVmQ&s",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        height: 2,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "General info",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Age: " + widget.age + " Years",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Email: " + widget.email,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Main Courses",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/1.jpeg',
                                height: 60,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Scratch Garden",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  LinearProgressIndicator(
                                    value: double.parse(
                                        snapshot.data.docs[i]["c1"]),
                                    backgroundColor: Colors.black12,
                                    color: kPrimaryColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/2.jpeg',
                                height: 60,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "LearningMole",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  LinearProgressIndicator(
                                    value: double.parse(
                                        snapshot.data.docs[i]["c2"]),
                                    backgroundColor: Colors.black12,
                                    color: kPrimaryColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/4.jpeg',
                                height: 60,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ScratchJr Coding"),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  LinearProgressIndicator(
                                    value: double.parse(
                                        snapshot.data.docs[i]["c3"]),
                                    backgroundColor: Colors.black12,
                                    color: kPrimaryColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/3.jpeg',
                                height: 60,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "HTML & CSS",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  LinearProgressIndicator(
                                    value: double.parse(
                                        snapshot.data.docs[i]["c4"]),
                                    backgroundColor: Colors.black12,
                                    color: kPrimaryColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
