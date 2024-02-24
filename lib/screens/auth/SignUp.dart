import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:newsify/screens/home/HomePage.dart';
import 'package:newsify/services/AuthServices.dart';
import 'LoginPage.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("SignUp Page"),
            backgroundColor: Colors.amberAccent,
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: SignUpForm(),
          )
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController conPwController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
              labelText: "Enter email",
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              )
          ),
        ),
        SizedBox(height: 20,),
        TextField(
          controller: pwController,
          decoration: InputDecoration(
            labelText: "Enter password",
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          obscureText: true,
        ),SizedBox(height: 20,),
        TextField(
          controller: conPwController,
          decoration: InputDecoration(
              labelText: "Confirm password",
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              )
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(onPressed: () async {
          // Add SignUp actions
          String email = emailController.text;
          String pw = pwController.text;
          String conpw = conPwController.text;
          if(email.isNotEmpty && pw.isNotEmpty && conpw.isNotEmpty){
            if(pw == conpw){
              dynamic user = await authService.userSignUp(email, pw);
              print(user);
              if(user != null) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
              }
              else{
                // add alert
                print("Login failed");
              }
            }
            else{
              // add alert to show "PWs do not match"
            }
          }
          else{
            // add alert to display "Fill all details"
          }

        },
          child: Text('SignUp'),
          ),

        SizedBox(height: 20,),
        TextButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
            child: Text("Already have an account? Log in here!",
              style: TextStyle(
                  fontSize: 18.0
              ),
            )
        )
      ],
    );
  }

  // showAlert(String alertName, String text){
  //   String actionBtn = "OK";
  //   if(alertName=='Congratulations'){
  //     setState(() {
  //       actionBtn = 'Sign in';
  //     });
  //   }
  //   return showDialog(context: context, builder: (BuildContext context){
  //     return AlertDialog(
  //       title: Text(alertName),
  //       content: Text(text),
  //       actions: [
  //         TextButton(
  //             onPressed: (){
  //               if(actionBtn == 'Sign in'){
  //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  //               }
  //               else {
  //                 Navigator.of(context).pop();
  //               }
  //             },
  //             child: Text(actionBtn))
  //       ],
  //     );
  //   }
  //   );
  // }
}


