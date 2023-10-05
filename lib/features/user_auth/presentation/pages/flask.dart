import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String responseMessage=' ';
String param1=' ';
String param2=' ';
String email=' ';
String res='';
bool valid=false;
class flask extends StatefulWidget {
  const flask({Key?key}) :super(key:key);

  @override
  State<flask> createState() => _flask();
}
class _flask extends State<flask>{
  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)!.settings.arguments);
    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = arguments['email'];
    param1=arguments['param1'];
    param2=arguments['param2'];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter to Flask'),
        ),
        body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(res),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchData,
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            Text(responseMessage),

            ElevatedButton(
              onPressed: () {
                sendDataToFlask(arguments['email']);
              },
              child: Text('Send Data to Flask'),
            ),
            ElevatedButton(onPressed:(){
              Navigator.pushNamed(context,"/final",arguments:{'email':email,'param1':param1,'param2':param2});
            },
                child: Text('final')),


          ],

        ),

      ),

    ));
  }

  Future<http.Response> sendDataToFlask(String data) async {
    final url = 'https://419c-2409-408c-2682-231c-99f4-3cd3-9afe-ac0.ngrok-free.app/store_name'; // Replace with your Flask server URL and endpoint
    final response = await http.post(
      Uri.parse(url),
      body: {'data': data}, // You can send data as key-value pairs in the body
    );
    Map<String, dynamic> dat;
    if (response.statusCode == 200) {
      setState(() {
        responseMessage = response.body;
      });
    } else {
      setState(() {
        responseMessage = 'Request failed with status: ${response.statusCode}';
      });
    }
    return response;
  }
  Future<void> fetchData() async {
    print("route");
    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email =arguments['email'];
    param1=arguments['param1'];
    param2=arguments['param2'];
    print('param1'+param1);
    int i1=param1.indexOf('%');
    int i2=param2.indexOf('%');
    print("in flask file");
    // String link='https://3885-2409-4070-2184-f7b2-c4dd-f750-2bfa-102b.ngrok-free.app';
    // String link='https://566c-2409-4070-209a-3daf-34cc-a259-ce39-1b7d.ngrok-free.app/data?param1='+param1+'&param2='+param2;
    String link='https://419c-2409-408c-2682-231c-99f4-3cd3-9afe-ac0.ngrok-free.app/data?param1='+param1.substring(0,i1)+'&p1='+param1.substring(i1+1)+
        '&param2='+param2.substring(0,i2)+'&p2='+param2.substring(i2+1);
    print(link);
    final response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      setState(() {
        responseMessage = response.body;
        print(responseMessage);
        Map<String, dynamic> dat;
        dat = json.decode(responseMessage.toString());
        print('verified:');
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
  }
}
