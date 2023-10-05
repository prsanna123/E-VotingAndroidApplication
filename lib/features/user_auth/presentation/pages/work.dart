// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// class work extends StatefulWidget{
//   const work({Key?key}):super(key:key);
//   @override
//   State<work> createState()=>_work();
// }
//
// String email=' ';
// String param1=' ';
// String param2=' ';
// class _work extends State<work>{
//   late DatabaseReference dbRef1;
//   late DatabaseReference dbref2;
//
//   @override
//   void initState() {
//     super.initState();
//     dbRef1 = FirebaseDatabase.instance.ref().child('Students');
//     dbref2=FirebaseDatabase.instance.ref().child('verification');
//     // dataFuture = fetchData();
//   }
//   late Future<String> dataFuture;
//   @override
//   Widget build(BuildContext context){
//     Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     email = arguments['email'];
//     param1=arguments['param1'];
//     param2=arguments['param2'];
//     return FutureBuilder<String>(
//       // future: dataFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         } else {
//           return SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Text(snapshot.data ?? ''),
//           );
//         }
//       },
//     );
//   }
//   Future<String> fetchData() async {
//     int i1=param1.indexOf('token');
//     int i2=param2.indexOf('token');
//     String link='https://60e7-2401-4900-62c3-6a8f-106-4701-88f6-cb02.ngrok-free.app?param1='+param1+'param2='+param2;
//     // String link='https://60e7-2401-4900-62c3-6a8f-106-4701-88f6-cb02.ngrok-free.app?param1='+param1.substring(0,i1+5)+'1'+param1.substring(i1+5)+'param2='+param2.substring(0,i2+5)+'2'+param2.substring(i2+5);
//     print(link);
//     final response = await http.get(Uri.parse(link));
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }


// class DataDisplayWidget extends StatefulWidget {
//   @override
//   _DataDisplayWidgetState createState() => _DataDisplayWidgetState();
// }
//
// // class _DataDisplayWidgetState extends State<DataDisplayWidget> {
//   late Future<String> dataFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     dataFuture = fetchData();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String>(
//       future: dataFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         } else {
//           return SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Text(snapshot.data ?? ''),
//           );
//         }
//       },
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';


class work extends StatefulWidget {
  const work({Key?key}):super(key:key);
  @override
  State<work> createState()=> _work();
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter and Flask',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: work(),
    );
  }
}

String param1=' ';
String param2=' ';
String email=' ';

class _work extends State<work> {
  late DatabaseReference dbRef;

  String responseMessage = '';
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('verification');
  }
  Future<void> fetchData() async {
    int i1=param1.indexOf('token');
    int i2=param2.indexOf('token');
    print("in work file");
    // String link='https://566c-2409-4070-209a-3daf-34cc-a259-ce39-1b7d.ngrok-free.app/data?param1='+param1+'&param2='+param2;
    String link='https://6960-2409-4070-209a-3daf-34cc-a259-ce39-1b7d.ngrok-free.app/data?param1='+param1.substring(0,i1+5)+'1'+param1.substring(i1+5)+'&param2='+param2.substring(0,i2+5)+'2'+param2.substring(i2+5);
    print(link);
    final response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      setState(() {
        responseMessage = response.body;
      });
    } else {
      setState(() {
        responseMessage = 'Request failed with status: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = arguments['email'];
    param1=arguments['param1'];
    param2=arguments['param2'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter and Flask Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchData,
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }
}

