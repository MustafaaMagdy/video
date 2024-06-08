import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player1/screens/details/network.dart';

class edit extends StatefulWidget {
  const edit({Key? key}) : super(key: key);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("Courses").get(),
        builder: (context, AsyncSnapshot snapshots) {
          if (snapshots.hasData == false) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.separated(
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: 250,
                    child: InkWell(
                      onTap: () async {
                        FirebaseFirestore.instance
                            .collection(snapshots.data.docs[i]["Name"])
                            .get();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Network(link: snapshots.data.docs[i]["V1"]),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Court Name',
                                    style: TextStyle(
                                      color: Colors.blueGrey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      snapshots.data.docs[i]["Des"].toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Court number',
                                    style: TextStyle(
                                      color: Colors.blueGrey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      snapshots.data.docs[i]["Name"].toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: snapshots.data.docs.length,
              ),
            );
          }
        },
      ),
    );
  }
}
