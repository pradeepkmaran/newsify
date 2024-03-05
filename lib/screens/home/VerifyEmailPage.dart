import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:newsify/screens/home/HomePage.dart';
import 'package:newsify/services/ApiServices.dart';
import 'package:newsify/services/AuthServices.dart';
import 'package:newsify/services/firestoreServices.dart';
import 'package:newsify/screens/auth/SignUp.dart';


class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});


  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}


class _VerifyEmailPageState extends State<VerifyEmailPage> {


  bool verify=false;
  Timer? timer;
  bool canresend=false;
  @override
  void initState(){
    super.initState();
    verify=FirebaseAuth.instance.currentUser!.emailVerified;
    if (!verify)
      sendVerificationEmail();


    timer=Timer.periodic(
      Duration(seconds: 3),(_)=>checkEmailVerified(),
    );


  }




  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      verify=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (verify) timer?.cancel();
  }




  Future sendVerificationEmail() async{
    final user=FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    setState(()=>canresend=false);
    await Future.delayed(Duration(seconds: 5));
    setState(()=>canresend=true);
  }


  @override
  Widget build(BuildContext context) => verify ?
  HomePage(category: "general",):
  Scaffold(appBar: AppBar(title:Text("Verify Email")),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'A verification has been sent to your mail!',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height:10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.email,size: 32,),
            label: Text('Resend Email',style: TextStyle(fontSize: 24),),
            onPressed: (){sendVerificationEmail();},
          )
        ],
      ),
    ),


  );


}
