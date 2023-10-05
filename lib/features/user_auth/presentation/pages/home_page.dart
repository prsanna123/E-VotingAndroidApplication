// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("HomePage"),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(child: Text("Welcome Home buddy!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),)),
//             SizedBox(height: 30,),
//             GestureDetector(
//               onTap: (){
//                 FirebaseAuth.instance.signOut();
//                 Navigator.pushNamed(context, "/login");
//
//               },
//               child: Container(
//                 height: 45,
//                 width: 100,
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: Center(child: Text("Sign out",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),
//               ),)
//
//
//           ],
//         )
//     );
//   }
// }


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:samp/features/user_auth/presentation/pages/dest.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final  userNameController = TextEditingController();
  final  userAgeController= TextEditingController();
  final  userSalaryController =TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Students');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserting data'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Inserting data in Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                  hintText: 'Enter Your Age',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userSalaryController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Salary',
                  hintText: 'Enter Your Salary',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> students = {
                    'name': userNameController.text,
                    'age': userAgeController.text,
                    'salary': userSalaryController.text
                  };

                  dbRef.push().set(students);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => dest()), (route) => false);

                },
                child: const Text('Insert Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
              GestureDetector(
                onTap:_home,
                child:Container(
                  width:double.infinity,
                  decoration: BoxDecoration(
                    color:Colors.orangeAccent,
                    borderRadius:BorderRadius.circular(10)
                  ),
                  child:Center(
                    child:Text(
                      "leave"
                    )
                  )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
  void _home() {
    Navigator.pushNamed(context,"/dest");
}
}
