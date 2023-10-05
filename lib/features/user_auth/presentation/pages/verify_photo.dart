// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:samp/api/firebase_api.dart';
// import 'package:samp/widget/button_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path/path.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:samp/Api.dart';
// // Future main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await SystemChrome.setPreferredOrientations([
// //     DeviceOrientation.portraitUp,
// //     DeviceOrientation.portraitDown,
// //   ]);
// //
// //   await Firebase.initializeApp();
// //
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   static final String title = 'Firebase Upload';
// //
// //   @override
// //   Widget build(BuildContext context) => MaterialApp(
// //     debugShowCheckedModeBanner: false,
// //     title: title,
// //     theme: ThemeData(primarySwatch: Colors.green),
// //     home: MainPage(),
// //   );
// // }
//
// class verify_photo extends StatefulWidget {
//   const verify_photo({Key?key}):super(key:key);
//   @override
//   State<verify_photo> createState()=> _VerifyPhoto();
// }
// String email=' ';
// class _VerifyPhoto extends State<verify_photo> {
//   UploadTask? task;
//   bool isButtonEnabled = false;
//   File? file;
//
//   @override
//   Widget build(BuildContext context) {
//     final fileName = file != null ? basename(file!.path) : 'No File Selected';
//     Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     email = arguments['email'];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Photo uploading'),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(32),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ButtonWidget(
//                 text: 'Select File',
//                 icon: Icons.attach_file,
//                 onClicked: selectFile,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 fileName,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 48),
//               ButtonWidget(
//                 text: 'Upload File',
//                 icon: Icons.cloud_upload_outlined,
//                 onClicked: uploadFile,
//               ),
//               SizedBox(height: 20),
//               task != null ? buildUploadStatus(task!) : Container(),
//               ElevatedButton(onPressed:(){
//                 Navigator.pushNamed(context, "/signUp");
//               },
//                   //     style:ElevatedButton.styleFrom(
//                   //           backgroundColor: isButtonEnabled?Colors.blue:Colors.grey
//                   // ),
//                   child: Text('uploading done')),
//               ElevatedButton(
//                 onPressed: () async {
//                    // Specify the username you want to search for
//                   await fetchDataByUsername(email); // Call the function
//                 },
//                 child: Text('Fetch Data'),
//               ),
//             ],
//
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future selectFile() async {
//     // final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//
//     if (pickedFile == null) return;
//     final path = pickedFile.path;
//
//     setState(() => file = File(path));
//   }
//
//   Future uploadFile() async {
//     if (file == null) return;
//     print("in uploading");
//     final fileName = basename(file!.path);
//     final destination = 'files/$fileName';
//
//     task = FirebaseApi.uploadFile(destination, file!);
//     setState(() {});
//
//     if (task == null) return;
//
//     final snapshot = await task!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//
//     print('Download-Link: $urlDownload');
//
//   }
//
//   Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
//     stream: task.snapshotEvents,
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         final snap = snapshot.data!;
//         final progress = snap.bytesTransferred / snap.totalBytes;
//         final percentage = (progress * 100).toStringAsFixed(2);
//         // if(progress==1) {
//         //       setState(() {
//         //           isButtonEnabled = true;
//         //         });
//         // }
//
//         return Text(
//           '$percentage %',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         );
//       } else {
//         return Container();
//       }
//     },
//   );
//
// // Function to retrieve data based on a username
//
// // Function to retrieve data based on a username
//   Future fetchDataByUsername(String username) async {
//     final reference = FirebaseDatabase.instance.reference().child('Students');
//
//     // Query to retrieve data where the username matches
//     final query = reference.orderByChild('name').equalTo(username);
//
//     // Get the DataSnapshot from the DatabaseEvent
//     final event = await query.once();
//
//     final dynamic snapshotValue = event.snapshot.value;
//
//     if (snapshotValue != null && snapshotValue is Map<dynamic, dynamic>) {
//       // Data found for the given username
//       Map<String, dynamic> values = Map<String, dynamic>.from(snapshotValue);
//       print(email);
//
//       values.forEach((key, value) {
//
//         // Process the individual key-value pairs as needed
//         // var collection = FirebaseFirestore.instance.collection('collection');
//         // collection
//         //     .doc('foo_id') // <-- Doc ID where data should be updated.
//         //     .update(newData);
//         value['pic2'] = 'This is extra information';
//         value['name']='pras';
//         print("Key: $key, Value: $value");
//         // Update the modified value back to Firebase
//         reference.child(key).update(value);
//       });
//       // 'values' now contains data related to the specified username
//       // You can process the data as needed
//     } else {
//       print('no data');
//     }
//   }
//
//
// }

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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
import 'package:samp/features/user_auth/presentation/pages/login_page.dart' as lp;
import 'package:samp/Api.dart';

String responseMessage='Wait whike we are fetching your data';
String res='';
bool valid=false;
class verify_photo extends StatefulWidget {
  const verify_photo({Key?key}):super(key:key);
  @override
  State<verify_photo> createState()=> _VerifyPhoto();
}
String email=' ';
String param1=' ';
String param2=' ';
Color buttonColor=Colors.grey;

class _VerifyPhoto extends State<verify_photo> {
  UploadTask? task;
  bool isButtonEnabled = false;
  File? file;
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('verification');
  }
  @override
  Widget build(BuildContext context) {
    if (!valid) {
      buttonColor = Colors.grey; // Change color to grey when btn is false
    } else {
      buttonColor = Colors.pinkAccent; // Change color to green when btn is true
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
                      child: Text('Make sure you are clicking picture in the lightining'),
                    ),
                    PopupMenuItem<String>(
                      value: 'option2',
                      child: Text('Place the face at the middle of the camera'),
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

            )]
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
              ElevatedButton(
                onPressed: () async {
                  // Specify the username you want to search for
                  await fetchDataByUsername(email); // Call the function
                },
                child: Text('Fetch Data'),
              ),
              // ElevatedButton(onPressed:(){
              //   Navigator.pushNamed(context, "/python",arguments: {'email':email,'param1':param1,'param2':param2} );
              // },
              //     //     style:ElevatedButton.styleFrom(
              //     //           backgroundColor: isButtonEnabled?Colors.blue:Colors.grey
              //     // ),
              //     child: Text('verify da'))
              ElevatedButton(
                onPressed: () {
                  sendDataToFlask(arguments['email']);
                },
                child: Text('Send Data to Flask'),
              ),
              ElevatedButton.icon(onPressed: valid ? ()=>{
              Navigator.pushNamed(context,"/final",arguments:{'email':email,'param1':param1,'param2':param2})} : null,
              style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  padding: EdgeInsets.all(20)
              ),
                icon: Icon(Icons.camera), // Add the camera icon
                label: Text('Vote'),),
              Text(responseMessage),

            ],

          ),
        ),
      ),
    );
  }
  Future selectFile() async {
    // final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    // if (result == null) return;
    // final path = result.files.single.path!;
    //
    // setState(() => file = File(path));
    if (pickedFile == null) return;
    final path = pickedFile.path;

    setState(() => file = File(path));
  }
  String urlDownload='';
  Future uploadFile() async {
    if (file == null) return;
    print("in uploading");
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }
  Future fetchDataByUsername(String username) async {
    // username='updated';
    final reference = FirebaseDatabase.instance.reference().child('Students');
    // final reference2=FirebaseDatabase.instance.reference().child('verification');
    // Query to retrieve data where the username matches
    // print("username"+username);
    final query = reference.orderByChild('name').equalTo(username);
    // final query2 = reference2.orderByChild('name').equalTo(username);

    // Get the DataSnapshot from the DatabaseEvent
    final event = await query.once();
    // final event2 = await query2.once();
    final dynamic snapshotValue = event.snapshot.value;
    // final dynamic snapshotValue2 = event2.snapshot.value;
    if (snapshotValue != null && snapshotValue is Map<dynamic, dynamic>) {
      // Data found for the given username
      Map<String, dynamic> values = Map<String, dynamic>.from(snapshotValue);
      print(email);
      values.forEach((key, value) async{
        reference.child(key).child('pic2').set(urlDownload).then((_){
              print("Value updated successfully");
            }).catchError((error) {
              print("Error updating value: $error");
        });
        print("Key: $key, Value: $value");
        String photo=value['pic1'].substring(0,value['pic1'].indexOf('&token'));
        setState(() {
          param1=photo;
        });
        String photo2=value['pic2'].substring(0,value['pic2'].indexOf('&token'));
        setState(() {
          param2=photo2;
        });
        print('photo1:'+photo+'photo2'+photo2);
      });
    } else {
      print('no data');
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );


  Future<http.Response> sendDataToFlask(String data) async {
    print("route");
    print('param1'+param1);
    int i1=param1.indexOf('%');
    int i2=param2.indexOf('%');
    String link='https://419c-2409-408c-2682-231c-99f4-3cd3-9afe-ac0.ngrok-free.app/data?param1='+param1.substring(0,i1)+'&p1='+param1.substring(i1+1)+
        '&param2='+param2.substring(0,i2)+'&p2='+param2.substring(i2+1);
    print(link);
    setState(() {
      valid=true;
    });
    final response = await http.get(Uri.parse(link));
    setState(() {
      valid=true;
    });
    if (response.statusCode == 200) {
      setState(() {
        responseMessage = response.body;
        print(responseMessage);
        Map<String, dynamic> dat;
        dat = json.decode(responseMessage.toString());
        print('verified:');
        setState(() {
          valid=true;
        });
        if(dat['verified']=='true'){
          setState(() {
            valid=true;
          });
          res='trues';
        }
        else res='falses';
      });
    } else {
      setState(() {
        responseMessage = 'Request failed with status: ${response.statusCode}';
      });
    }
    final url = 'https://419c-2409-408c-2682-231c-99f4-3cd3-9afe-ac0.ngrok-free.app/store_name'; // Replace with your Flask server URL and endpoint
    final respons = await http.post(
      Uri.parse(url),
      body: {'data': data}, // You can send data as key-value pairs in the body
    );
    Map<String, dynamic> dat;
    if (respons.statusCode == 200) {
      setState(() {
        responseMessage = respons.body;
      });
    } else {
      setState(() {
        responseMessage = 'Request failed with status: ${respons.statusCode}';
      });
    }
    return respons;
  }
}

