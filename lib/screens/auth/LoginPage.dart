import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:newsify/screens/home/HomePage.dart';
import 'package:newsify/services/AuthServices.dart';
import 'SignUp.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Form",textDirection: TextDirection.ltr),
        backgroundColor:Colors.deepOrange,
        centerTitle: true,
      ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: LoginForm(),
        )
    );
    //);
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
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
              )
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(onPressed: () async {
          // Add login actions
          String email = emailController.text;
          String pw = pwController.text;
          if(email.isNotEmpty && pw.isNotEmpty){
            dynamic user = await authService.userLogIn(email, pw);
            print(user);
            if(user != null){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(category: "general",)));
            }
            else{
              showAlert("User doesnt exist", "Signup to enter the app.");
            }
          }
          else{
            showAlert("Fields empty", "Enter all fields to login");
          }
        },
          child: const Text('Login'),
        ),
        const SizedBox(height: 20,),
        TextButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
        },
            child: const Text("Dont have an account? Sign Up here!",
              style: TextStyle(
                  fontSize: 18.0
              ),
            )
        )
      ],
    );
  }

  // This function is to show alert dialogs
  showAlert(String alertName, String text){
    String actionBtn = "OK";
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(alertName),
        content: Text(text),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text(actionBtn))
        ],
      );
    }
    );
  }

}
