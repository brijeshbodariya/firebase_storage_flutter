import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image!.path);
        if (kDebugMode) {
          print('Image Path $_image');
        }
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image!.path);
      try {
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref('storageImages/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
        uploadTask.whenComplete(() {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile Picture Uploaded')));
          });
        });
      } on FirebaseException catch (e) {
        log('Exception code ${e.code} : ${e.message} due to ${e.stackTrace} ');
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text('Edit Profile'),
      ),
      body: Builder(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: const Color(0xff476cfb),
                    child: ClipOval(
                      child: SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: (_image != null)
                            ? Image.file(
                                _image!,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.camera,
                      size: 30.0,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Username',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Michelle James',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    FontAwesomeIcons.pen,
                    color: Color(0xff476cfb),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Birthday',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('1st April, 2000',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    FontAwesomeIcons.pen,
                    color: Color(0xff476cfb),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Location',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Paris, France',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    FontAwesomeIcons.pen,
                    color: Color(0xff476cfb),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text('Email',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                  SizedBox(width: 20.0),
                  Text('michelle123@gmail.com',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff476cfb)),
                    elevation: MaterialStateProperty.all(4),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff476cfb)),
                    elevation: MaterialStateProperty.all(4),
                  ),
                  onPressed: () => uploadPic(context),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
