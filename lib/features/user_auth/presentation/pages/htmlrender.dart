import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class htmlrender extends StatefulWidget {
  const htmlrender({Key?key}) :super(key: key);

  @override
  State<htmlrender> createState() => _htmlrender();
}
String email='';
String mail='';
class _htmlrender extends State<htmlrender>{
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = arguments['email'];
    return MaterialApp(
        // title: 'Flutter Demo',
        // theme: ThemeData(
        //   useMaterial3: true,
        // ),
        // home: const MyStatefulWidget()
      home:Scaffold(
        appBar: AppBar(
          title:Text('Flutter'),
          leading:IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            // Navigator.pop(context);
            exit(0);
          },),
        ),
        body:const MyStatefulWidget(),

      )
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print("route");
    print(ModalRoute.of(context)!.settings.arguments);

    mail='https://419c-2409-408c-2682-231c-99f4-3cd3-9afe-ac0.ngrok-free.app?email='+email;
    print(email);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(mail));

    return Scaffold(
        body: WebViewWidget(controller: controller)
        );
  }
}