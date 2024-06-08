import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player1/constants/constants.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Redeem points',
          style: TextStyle(),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Points")
            .where("Name", isEqualTo: UserName)
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
              itemBuilder: (context, i) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/q.webp"),
                          const Divider(
                            color: Colors.orange,
                            thickness: 1.0,
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Redeem now',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Aldrich',
                              ),
                            ),
                          ),
                          Text(
                            'My points : ' + snapshot.data.docs[i]["Points"],
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
