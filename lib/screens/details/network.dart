import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player1/lessons/lesson2.dart';
import 'package:video_player1/screens/Child/base_screen.dart';
import '../../constants/icons.dart';
import '../../models/lesson.dart';

class Network extends StatefulWidget {
  final String link;

  const Network({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  _NetworkState createState() => _NetworkState();
}

final TextEditingController _textFieldController = TextEditingController();

late VideoPlayerController _controller;
Widget? controls;
bool _isPlaying = false;
late Duration _duration;
late Duration _position;
bool _isEnd = false;

class _NetworkState extends State<Network> {
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
                ? setState(() {
                    _isEnd = true;
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
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const BaseScreen(),
                    ),
                    (route) => false);
              },
              child: Icon(Icons.arrow_back)),
          title: Text(
            "Course Screen",
            style: TextStyle(color: Colors.white),
          ),
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
                      "Dive into the world of coding for kids. Learn about block-based coding, game-based coding, and the basics of programming for young learners. Build your skills to create interactive programs and apps.",
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
        itemCount: c2.length,
        itemBuilder: (_, index) {
          return LessonCard2(lesson: c2[index]);
        },
      ),
    );
  }
}
