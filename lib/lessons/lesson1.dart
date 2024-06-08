import 'package:flutter/material.dart';
import 'package:video_player1/screens/details/details_screen.dart';

import '../models/lesson.dart';

class LessonCard extends StatefulWidget {
  final Lesson lesson;

  const LessonCard({Key? key, required this.lesson}) : super(key: key);

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.orange,
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                          link: widget.lesson.link,
                          v: widget.lesson.V,
                        )));
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tap to play",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.lesson.duration,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.play_arrow,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
