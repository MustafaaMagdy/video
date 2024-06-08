import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../constants/constants.dart';
import '../../constants/icons.dart';
import '../../lessons/lesson1.dart';
import '../../models/lesson.dart';
import '../Child/base_screen.dart';

class DetailsScreen extends StatefulWidget {
  final String link;
  final String v;

  const DetailsScreen({
    Key? key,
    required this.link,
    required this.v,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

late VideoPlayerController _controller;
Widget? controls;
bool _isPlaying = false;
late Duration _duration;
late Duration _position;
bool _isEnd = false;
var id;
late bool found;
late var Course_ID;
late var prog_ID;
late var Points_ID;
late var p0ints;
late var prog;

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      widget.link,
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;

        if (_controller.value.isPlaying && isPlaying != _isPlaying) {
          controls = GestureDetector(
              onTap: () {
                setState(() {
                  _controller.pause();
                });
              },
              child: Icon(Icons.pause));
        } else if (_controller.value.position.inMilliseconds -
                _controller.value.duration.inMilliseconds <
            1) {
          setState(() {
            controls = GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.play();
                  });
                },
                child: Icon(Icons.play_arrow));
          });
          {
            {
              setState(() {
                _isPlaying = isPlaying;
              });
            }
            Timer.run(() {
              setState(() {
                _position = _controller.value.position;
              });
            });
            setState(() {
              _duration = _controller.value.duration;
            });
            _duration.compareTo(_position) == 0 ||
                    _duration.compareTo(_position) == -1
                ? setState(() async {
                    _isEnd = true;
                    var users = FirebaseFirestore.instance
                        .collection("Course1")
                        .where("Name", isEqualTo: UserName);
                    var userquerySnapshot = await users.get();
                    for (var userDocumentSnapshot in userquerySnapshot.docs) {
                      Map<String, dynamic> data = userDocumentSnapshot.data();
                      if (data[widget.v].toString() == "false") {
                        id = userDocumentSnapshot.id;
                        Course_ID = id.toString();
                        found = true;
                      }
                    }
                    if (found == true) {
                      await FirebaseFirestore.instance
                          .collection("Course1")
                          .doc(Course_ID)
                          .update(<String, dynamic>{
                        widget.v: "true",
                      });
                      var users = FirebaseFirestore.instance
                          .collection("Progress")
                          .doc(UserName)
                          .collection("courses");
                      var userquerySnapshot = await users.get();
                      for (var userDocumentSnapshot in userquerySnapshot.docs) {
                        Map<String, dynamic> data = userDocumentSnapshot.data();
                        if (data["Name"] == UserName) {
                          id = userDocumentSnapshot.id;
                          prog_ID = id.toString();
                          prog = data['c1'];
                        }
                      }
                      double a = 0.1;
                      double c = double.parse(prog) + a;
                      await FirebaseFirestore.instance
                          .collection("Progress")
                          .doc(UserName)
                          .collection("courses")
                          .doc(prog_ID)
                          .update(<String, dynamic>{
                        "c1": c.toString(),
                      });

                      var points =
                          FirebaseFirestore.instance.collection("Points");
                      var querySnapshot = await points.get();
                      for (var userDocumentSnapshot in querySnapshot.docs) {
                        Map<String, dynamic> data = userDocumentSnapshot.data();
                        if (data["Name"] == UserName) {
                          id = userDocumentSnapshot.id;
                          Points_ID = id.toString();
                          p0ints = data['Points'];
                        }
                      }
                      int g = 10;
                      int f = int.parse(p0ints) + g;
                      await FirebaseFirestore.instance
                          .collection("Points")
                          .doc(Points_ID)
                          .update(<String, dynamic>{
                        "Points": f.toString(),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Congrats you got Rewards'),
                        ),
                      );
                    }
                  })
                : setState(() {
                    _isEnd = false;
                  });
          }
        } else {
          controls = GestureDetector(
            onTap: () {
              setState(() {
                _controller.play();
                if (_isEnd == true) {}
              });
            },
          );
        }
      });
  }

  @override
  void dispose() {
    setState(() {
      super.dispose();
      _controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Course Screen",
            style: TextStyle(color: Colors.white),
          ),
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const BaseScreen(),
                    ),
                    (route) => false);
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Colors.orange,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Stack(
                          children: [
                            VideoPlayer(
                              _controller,
                            ),
                            _controller.value.isInitialized
                                ? AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(
                                      _controller,
                                    ),
                                  )
                                : Container(),
                            Text(
                              'isEnd?  $_isEnd',
                              style: TextStyle(color: Colors.white),
                            ),
                            Positioned.fill(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  controls ??
                                      const Text(
                                        "Loading",
                                        style: TextStyle(),
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        top: 170,
                        child: VideoProgressIndicator(_controller,
                            allowScrubbing: true),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          icFeaturedOutlined,
                          height: 20,
                        ),
                        const Text(
                          " 4.8",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(
                          Icons.timer,
                          color: Colors.grey,
                        ),
                        const Text(
                          " 2 Hours",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Text(
                      "Explore the fundamentals of programming through fun, interactive lessons. Learn core concepts like sequences, loops, and variables to create simple programs.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                PlayList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayList extends StatelessWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 20,
          );
        },
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        shrinkWrap: true,
        itemCount: c1.length,
        itemBuilder: (_, index) {
          return LessonCard(lesson: c1[index]);
        },
      ),
    );
  }
}
