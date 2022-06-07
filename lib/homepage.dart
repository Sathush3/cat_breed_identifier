import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

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
  String result = '';
  late ImagePicker imagePicker;

  //Functions

// selecting photo
  selectPhoto() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
      _loading = false; //temp change later
    }

    setState(() {
      _loading; //temp change later
      _image;
      doImageClassification();
    });
  }

// capture from camera
  capturePhoto() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
      _loading = false; //temp change later
    }

    setState(() {
      _image;
      _loading; //temp change later
      doImageClassification();
    });
  }

// load model
  loadDataModel() async {
    print("load mdel");

    await Tflite.loadModel(
        model: 'model/model_unquant.tflite',
        labels: 'model/labels.txt',
        numThreads: 1,
        useGpuDelegate: false);
    print('model loaded');
    //print(output);
  }

  // prediction
  doImageClassification() async {
    print("image classify");
    var recognition = await Tflite.runModelOnImage(
        path: _image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.1,
        asynch: true);

    print(recognition?.length.toString());
    print(recognition);

    setState(() {
      result = '';
    });
    recognition?.forEach((element) {
      setState(() {
        print(element.toString());
        result += element['label'];
      });
    });
  }
  // initilaizing

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadDataModel();
  }

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
                height: 20,
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
                            child: //_image != null
                                // change to image later
                                _loading == false
                                    ? Image.file(
                                        _image,
                                        height: 200,
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
