import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player1/constants/constants.dart';
import 'package:video_player1/screens/Parent/child_screen.dart';

class My_Childs extends StatefulWidget {
  const My_Childs({Key? key}) : super(key: key);

  @override
  State<My_Childs> createState() => _My_ChildsState();
}

class _My_ChildsState extends State<My_Childs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Child")
            .where('Parent', isEqualTo: UserName)
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
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 4.0,
                            spreadRadius: .05,
                          ), //BoxShadow
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Child_screen(
                                        age: snapshot.data.docs[i]["Age"],
                                        name: snapshot.data.docs[i]["Name"],
                                        email: snapshot.data.docs[i]["Email"],
                                        progress: 0.8,
                                      )));
                        },
                        child: SingleChildScrollView(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNMLXMlOfq_uOypUzMeQ8rHpFmrlyF6pLVmQ&s",
                                  height: 125,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Center(
                                  child: Text(
                                snapshot.data.docs[i]["Name"],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return const Divider(
                    color: Colors.grey,
                    endIndent: 20,
                    indent: 20,
                    thickness: 1,
                  );
                });
          }
        },
      ),
    );
  }
}
