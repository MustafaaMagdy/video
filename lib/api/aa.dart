import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<int> storagePermissionChecker;



  void checkPermissions() async {

    Map<Permission, PermissionStatus> statuses = await [
      Permission.ignoreBatteryOptimizations,
      Permission.notification,
      Permission.location,
      Permission.bluetooth,
    ].request();
    // perform custom action

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: storagePermissionChecker,
        builder: (context, status) {
          if (status.connectionState == ConnectionState.done) {
            if (status.hasData) {
              if (status.data == 1) {
                return MyHome();
              } else {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      child: Text(
                        "Allow storage Permission",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                         checkPermissions();

                        setState(() {});
                      },
                    ),
                  ),
                );
              }
            } else {
              return Scaffold(
                  body: Center(
                    child: Text(
                        'Something went wrong.. Please uninstall and Install Again'),
                  ));
            }
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Hello')),
    );
  }
}