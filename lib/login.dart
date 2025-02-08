import 'package:flutter/material.dart';
import 'package:indeed/main.dart';
import 'package:indeed/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import 'package:get/get.dart';

class MyLogin extends StatefulWidget {

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/back4.jpg'), // Path to your background image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListView( shrinkWrap: true,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 300, 20),
                          child: Icon(Icons.arrow_back_ios,size: 30,)
                      ),

                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.only(right: 30,left: 30),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome Back.', style: TextStyle( color: Colors.black, fontSize: 50, fontFamily: 'nexalight'),),
                            Text('Unlock endless job opportunities Login to get Started', style: TextStyle( color: Colors.black, fontSize: 15, fontFamily: 'sans-serif-thin'),),

                          ],
                        ),

                      ),
                      SizedBox(height: 70,),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(right: 30,left: 30),
                          child: Column(
                            children: [
                              TextField( cursorColor: Colors.black,style: TextStyle( fontFamily: 'sans-serif-light'),
                                controller: usernameController,
                                decoration: InputDecoration(
                                  fillColor: Colors.pink,
                                  hintText: 'Enter your Email',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),// Focused border color
                                      borderRadius: BorderRadius.circular(35)
                                  ),
                                ),
                              ),
                              SizedBox(height: 30,),
                              TextField(style: TextStyle( fontFamily: 'sans-serif-light'),
                                controller: passwordController,
                                cursorColor: Colors.black,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[100],
                                  hintText: 'Enter your Password',
                                  border: OutlineInputBorder( // Unfocused border color
                                      borderRadius: BorderRadius.circular(35)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),// Focused border color
                                      borderRadius: BorderRadius.circular(35)
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked = value ?? false;
                                      });
                                    },
                                    activeColor: Colors.green, // Change the color when checked
                                  ),
                                  Text('As Employer',style: TextStyle(fontFamily: 'sans-serif-thin',fontSize: 13),),
                                  SizedBox(width: 100,),
                                  Text('Forget Password?',style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'sans-serif-light'),textAlign: TextAlign.right,),
                                ],
                              ),
                              SizedBox(height: 35,),
                              SizedBox(
                                height: 50,
                                width: 450,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.blueAccent, backgroundColor: Colors.blueAccent, // Set the text color here
                                  ),  onPressed: () {
                                    login(context);
                                  // Get.to(()=>MyHomePage());
                                },
                                  child: Text('Login',style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'sans-serif-medium'),),
                                ),
                              ),

                              SizedBox(height: 39,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 46,
                                    width: 350,
                                    child:
                                    // ElevatedButton(
                                    //   onPressed: () async {
                                    //     User? user = await signInWithGoogle();
                                    //     if (user != null) {
                                    //       print('User  signed in: ${user.displayName}');
                                    //     }
                                    //   },
                                    //   child: Text('Log in with Google',style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: 'sans-serif-light'),textAlign: TextAlign.right,),
                                    // ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black, backgroundColor: Colors.white70, // Set the text color here
                                      ),  onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/google.png', height: 29,),
                                          SizedBox(width: 15,),
                                          Text('Log in With Google',style: TextStyle(fontFamily: 'nexalight',fontSize: 15,color: Colors.black),),
                                        ],
                                      )
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 60,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('You Don\'t Have an Account yet?', style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'sans-serif-light'),),
                                  SizedBox(width: 50,),

                                  InkWell(
                                    onTap: () {
                                      Get.to(()=>MySignUpPage());
                                    },
                                    child: Text('Sign Up',style: TextStyle(color: Colors.blueAccent),),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ]
            )
        )
    );
  }

  void login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString("username");
    String? storedPassword = prefs.getString("password");
    print(storedPassword);
    print(storedUsername);
    if (usernameController.text == storedUsername && passwordController.text == storedPassword) {
      // Navigate to home screen
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));

    }
  }
}


// Future<User?> signInWithGoogle() async {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final GoogleSignInAccount? googleUser  = await googleSignIn.signIn();
//   final GoogleSignInAuthentication? googleAuth = await googleUser ?.authentication;
//
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//
//   return (await FirebaseAuth.instance.signInWithCredential(credential)).user;
// }
//
// Future<void> signOut() async {
//   await FirebaseAuth.instance.signOut();
//   await GoogleSignIn().signOut();
// }