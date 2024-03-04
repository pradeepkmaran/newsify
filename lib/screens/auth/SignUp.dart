import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:newsify/screens/home/HomePage.dart';
import 'package:newsify/services/ApiServices.dart';
import 'package:newsify/services/AuthServices.dart';
import 'package:newsify/services/firestoreServices.dart';
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
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController conPwController = TextEditingController();
  AuthService authService = AuthService();
  FirestoreServices firestoreServices = FirestoreServices();

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
          controller: usernameController,
          decoration: InputDecoration(
            labelText: "Enter username",
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),SizedBox(height: 20,),
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
        ElevatedButton(
          onPressed: () async {
            // Retrieve user input
            String email = emailController.text;
            String username = usernameController.text;
            String pw = pwController.text;
            String conpw = conPwController.text;

            // Check if all fields are filled
            if (email.isNotEmpty && pw.isNotEmpty && conpw.isNotEmpty && username.isNotEmpty) {
              // Check if the username is valid and unique
              int usernameStatus = await firestoreServices.isValidUsername(username);

              setState(() {
                if (usernameStatus == 1) {
                  // Username is valid and unique, proceed with signup
                  if (pw == conpw) {
                    authService.userSignUp(email, pw, username).then((user) {
                      if (user != null) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(category: "general",)));
                      } else {
                        // Show alert for login failure
                        print("Login failed");
                      }
                    });
                  } else {
                    // Show alert for password mismatch
                    print("Passwords do not match");
                  }
                } else if (usernameStatus == 0) {
                  // Show alert for non-unique username
                  print("Username is not unique");
                } else if (usernameStatus == -1) {
                  // Show alert for invalid username
                  print("Username is not valid");
                }
              });
            } else {
              // Show alert for empty fields
              print("Fill all details");
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


