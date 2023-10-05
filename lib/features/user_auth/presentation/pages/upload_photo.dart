import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:samp/api/firebase_api.dart';
import 'package:samp/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class upload_photo extends StatefulWidget {
  const upload_photo({Key?key}):super(key:key);
  @override
  State<upload_photo> createState()=> _UploadPhoto();
}
String email=' ';
bool showWidget = false;
String ans='Please wait while we are uploading the photo';
bool btn=true;
Color buttonColor=Colors.white;
class _UploadPhoto extends State<upload_photo> {
  UploadTask? task;
  bool isButtonEnabled = false;
  File? file;
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Students');
  }
  @override
  Widget build(BuildContext context) {
    if (!btn) {
      buttonColor = Colors.grey; // Change color to grey when btn is false
    } else {
      buttonColor = Colors.green; // Change color to green when btn is true
    }
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = arguments['email'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo uploading'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            child:Text('Instructions'),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'option1',
                  child: Text('Upload the image carefully'),
                ),
                PopupMenuItem<String>(
                  value: 'option2',
                  child: Text('In case of issues contact the higher official'),
                ),
                PopupMenuItem<String>(
                  value: 'option3',
                  child: Text('Donot take distorted pictures'),
                ),
              ];
            },
            onSelected: (String value) {
              // Handle menu item selection here
              print('Selected: $value');
            }

        )]),

      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ButtonWidget(
              //   text: 'Select File',
              //   icon: Icons.attach_file,
              //   onClicked: selectFile,
              // ),
              // SizedBox(height: 8),
              // Text(
              //   fileName,
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              // ),
              ElevatedButton.icon(
                onPressed: btn ? selectFile : null,
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                    padding: EdgeInsets.all(20)
                ),
                icon: Icon(Icons.camera), // Add the camera icon
                label: Text('Select photo'), // Add button text
              ),

              SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
              // ElevatedButton(onPressed:(){
              //   Navigator.pushNamed(context, "/verify",arguments: {'email':email} );
              // },
              // //     style:ElevatedButton.styleFrom(
              // //           backgroundColor: isButtonEnabled?Colors.blue:Colors.grey
              // // ),
              //     child: Text('uploading done')),
                  Text(ans),
                  ElevatedButton(
                  onPressed:(){SystemNavigator.pop();
                },
                    child: Text('Close App'),)

            ],

          ),
        ),
      )
    );
  }

  Future selectFile() async {
    // final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    // if (result == null) return;
    // final path = result.files.single.path!;

    // setState(() => file = File(path));
    if (pickedFile == null) return;
    final path = pickedFile.path;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;
    print("in uploading");
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;
    print("yes");
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    setState(() {
      btn=false;
    });
    setState(() => ans = 'done rey👍');
    Map<String, String> students = {
      'name': email,
      'pic1': urlDownload,
      'pic2':' '
    };
    dbRef.push().set(students);

  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        // if(progress==1) {
        //       setState(() {
        //           isButtonEnabled = true;
        //         });
        // }

            return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );
}
