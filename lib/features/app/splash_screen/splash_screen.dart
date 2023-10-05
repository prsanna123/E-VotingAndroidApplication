import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
final backgroundImage = Image.asset(
  'assets/register.png',
  fit: BoxFit.cover, // Optional: Adjust how the image fills the container
);
final backgroundContainer = Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/background_image.jpg'),
      fit: BoxFit.cover, // Optional: Adjust how the image fills the container
    ),
  ),
);

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 3),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
    }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImageWidget(),
    );
  }
}


class BackgroundImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Text(
            'Welcome to E-Voting Application!',
            style: TextStyle(
              fontSize: 24,
              color: Colors.red;
            ),
          ),
        ),
      ],
    );
  }
}