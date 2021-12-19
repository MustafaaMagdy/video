import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoPlayerWidget()
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController AssetController;
  late VideoPlayerController fileController;
  late VideoPlayerController networkController;
  bool isMute= false;
  String vURL = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  @override
  void initState() {
    super.initState();
    networkController= VideoPlayerController.network(vURL)
      ..initialize().then((value) {setState(() {

      });});
    AssetController = VideoPlayerController.asset("assets/abc.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown
        // after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    fileController = VideoPlayerController.file(new File(""))
      ..initialize().then((value) {
        fileController.play();
        setState(() {

        });
      });
  }
  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if( result ==null)
      return null;
    return File(result.files.single.path.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Video Player App"),
        ),
        // body: Container(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("From Asset" ,style: TextStyle(fontSize: 30),),
            ),
            buildVideoPlayer(AssetController),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("From Network", style: TextStyle(fontSize: 30),),
            ),
            buildVideoPlayer(networkController),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("From File", style: TextStyle(fontSize: 30),),
            ),
            buildVideoPlayer(fileController),

            ElevatedButton(onPressed: () async{
              final file = await pickFile();
              if (file ==null) return ;
              else {
                fileController = VideoPlayerController.file(file)
                  ..initialize().then((_) {
                    fileController.play();
                    setState(() {});
                  });
              }

            }, child: Text("Pick a File")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            setState(() {
              AssetController.setVolume(isMute?1:0);
              isMute =!isMute;
            });
          },
          child: Icon(
            isMute? Icons.volume_off_rounded : Icons.volume_up,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
  buildVideoPlayer(VideoPlayerController controller)
  {
    return Column(
      children: [
        Center(
          child: controller.value.isInitialized?
          AspectRatio(aspectRatio: controller.value.aspectRatio, child: VideoPlayer(controller),)
              : Container(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: ()async{
                  Duration? value =  await controller.position;
                  var d = value! - Duration(seconds: 10);
                  controller.seekTo(Duration(seconds: d.inSeconds));
                }, child: Text("<<")),
            ElevatedButton(
              child: Icon(Icons.play_arrow_rounded),
              onPressed: (){
                controller.play();
              },),
            ElevatedButton(
              child: Icon(Icons.pause_outlined),
              onPressed: (){
                controller.pause();
              }, ),
            ElevatedButton(onPressed:  ()async {
              Duration? value =  await controller.position;
              var d = Duration(seconds: 10)+value!;
              controller.seekTo(Duration(seconds: d.inSeconds));
            }, child: Text(">>")),

          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    AssetController.dispose();
    networkController.dispose();
    fileController.dispose();
  }
}


