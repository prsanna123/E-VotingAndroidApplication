// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // Future main() async{
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // Try running your application with "flutter run". You'll see the
// //         // application has a blue toolbar. Then, without quitting the app, try
// //         // changing the primarySwatch below to Colors.green and then invoke
// //         // "hot reload" (press "r" in the console where you ran "flutter run",
// //         // or simply save your changes to "hot reload" in a Flutter IDE).
// //         // Notice that the counter didn't reset back to zero; the application
// //         // is not restarted.
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }
// //
// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key, required this.title});
// //
// //   // This widget is the home page of your application. It is stateful, meaning
// //   // that it has a State object (defined below) that contains fields that affect
// //   // how it looks.
// //
// //   // This class is the configuration for the state. It holds the values (in this
// //   // case the title) provided by the parent (in this case the App widget) and
// //   // used by the build method of the State. Fields in a Widget subclass are
// //   // always marked "final".
// //
// //   final String title;
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   int _counter = 0;
// //
// //   void _incrementCounter() {
// //     setState(() {
// //       // This call to setState tells the Flutter framework that something has
// //       // changed in this State, which causes it to rerun the build method below
// //       // so that the display can reflect the updated values. If we changed
// //       // _counter without calling setState(), then the build method would not be
// //       // called again, and so nothing would appear to happen.
// //       _counter++;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // This method is rerun every time setState is called, for instance as done
// //     // by the _incrementCounter method above.
// //     //
// //     // The Flutter framework has been optimized to make rerunning build methods
// //     // fast, so that you can just rebuild anything that needs updating rather
// //     // than having to individually change instances of widgets.
// //     return Scaffold(
// //       appBar: AppBar(
// //         // Here we take the value from the MyHomePage object that was created by
// //         // the App.build method, and use it to set our appbar title.
// //         title: Text(widget.title),
// //       ),
// //       body: Center(
// //         // Center is a layout widget. It takes a single child and positions it
// //         // in the middle of the parent.
// //         child: Column(
// //           // Column is also a layout widget. It takes a list of children and
// //           // arranges them vertically. By default, it sizes itself to fit its
// //           // children horizontally, and tries to be as tall as its parent.
// //           //
// //           // Invoke "debug painting" (press "p" in the console, choose the
// //           // "Toggle Debug Paint" action from the Flutter Inspector in Android
// //           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
// //           // to see the wireframe for each widget.
// //           //
// //           // Column has various properties to control how it sizes itself and
// //           // how it positions its children. Here we use mainAxisAlignment to
// //           // center the children vertically; the main axis here is the vertical
// //           // axis because Columns are vertical (the cross axis would be
// //           // horizontal).
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             const Text(
// //               'You have pushed the button this many times:',
// //             ),
// //             Text(
// //               '$_counter',
// //               style: Theme.of(context).textTheme.headlineMedium,
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _incrementCounter,
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ), // This trailing comma makes auto-formatting nicer for build methods.
// //     );
// //   }
// // }
//
//
// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:samp/api/firebase_api.dart';
// import 'package:samp/widget/button_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path/path.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:samp/Api.dart';
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   await Firebase.initializeApp();
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   static final String title = 'Firebase Upload';
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: title,
//     theme: ThemeData(primarySwatch: Colors.green),
//     home: MainPage(),
//   );
// }
//
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   UploadTask? task;
//   File? file;
//
//   @override
//   Widget build(BuildContext context) {
//     final fileName = file != null ? basename(file!.path) : 'No File Selected';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(MyApp.title),
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
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
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
//
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
//   }
//
//   Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
//     stream: task.snapshotEvents,
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         final snap = snapshot.data!;
//         final progress = snap.bytesTransferred / snap.totalBytes;
//         final percentage = (progress * 100).toStringAsFixed(2);
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
// }



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:samp/features/app/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:samp/features/user_auth/presentation/pages/home_page.dart';
import 'package:samp/features/user_auth/presentation/pages/login_page.dart';
import 'package:samp/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:samp/features/user_auth/presentation/pages/dest.dart';
import 'package:samp/features/user_auth/presentation/pages/upload_photo.dart';
import 'package:samp/features/user_auth/presentation/pages/verify_photo.dart';
import 'package:samp/features/user_auth/presentation/pages/work.dart';
import 'package:samp/features/user_auth/presentation/pages/flask.dart';
import 'package:samp/features/user_auth/presentation/pages/htmlrender.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCsHDQtI9DItQgSqwy45_y2xG9tDGxuER8",
        appId: "1:540215271818:web:8b22d4aee01acdce862873",
        messagingSenderId: "540215271818",
        projectId: "flutter-firebase-9c136",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/dest':(context)=>dest(),
        '/upload':(context)=>upload_photo(),
        '/verify':(context)=>verify_photo(),
        '/python':(context)=>flask(),
        '/final':(context)=>htmlrender()

      },
    );
  }
}