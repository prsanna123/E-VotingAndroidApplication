import 'package:flutter/material.dart';
class dest extends StatefulWidget{
  const dest({Key?key}):super(key:key);
  @override
  State<dest> createState()=>_dest();
}
class _dest extends State<dest>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('Done')
      ),
      body:Center(
        child:Padding(
          padding:EdgeInsets.all(8.0),
          child:Column(
            children:[
              const SizedBox(
                height:50,
              ),
              const Text(
                'done with updation thank you'
              )
            ]
          ),

        )
      )
    );
  }
}