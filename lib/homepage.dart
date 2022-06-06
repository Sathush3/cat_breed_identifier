import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => MyHomepageState();
}

class MyHomepageState extends State<MyHomepage> {
  //Variables
  late Future<File> imageFile;
  bool _loading = true;
  late File _image;
  String result = 'test';
  late ImagePicker imagePicker;

  //Functions

// selecting photo
  selectPhoto() async {}

// capture from camera
  capturePhoto() async {}
// load model

  // prediction

  // initilaizing

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/2.2 background.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: TextButton(
                          onPressed: selectPhoto,
                          onLongPress: capturePhoto,
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 20, right: 35, left: 18),
                            child: // _image != null
                                // change to image later
                                _loading == false
                                    ? Image.file(
                                        _image,
                                        height: 160,
                                        width: 400,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 140,
                                        height: 190,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.black,
                                        ),
                                      ),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 160,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  '$result',
                  style: TextStyle(
                      fontFamily: 'Gentium Plus',
                      fontSize: 35,
                      color: Colors.blueAccent,
                      backgroundColor: Colors.white60),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
