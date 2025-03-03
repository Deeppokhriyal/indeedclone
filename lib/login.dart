import 'package:flutter/material.dart';
import 'package:indeed/employer_homepage.dart';
import 'package:indeed/main.dart';
import 'package:indeed/signup.dart';

import 'package:get/get.dart';

import 'api_service.dart';


class MyLogin extends StatefulWidget {

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final response = await ApiService.login(
        _emailController.text,
        _passwordController.text
    );

    if (response != null) {
      String role = response['user']['role'];

      if (role == 'employer') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed")));
    }
  }

  // bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox.expand(
                    child: ListView( shrinkWrap: true,
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 300, 20),
                            child: Icon(Icons.arrow_back_ios,size: 30,)
                        ),
                    
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.only(right: 30,left: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Welcome Back.', style: TextStyle( color: Colors.black, fontSize: 50, fontFamily: 'nexalight'),),
                              Text('Unlock endless job opportunities Login to get Started', style: TextStyle( color: Colors.black, fontSize: 15, fontFamily: 'sans-serif-thin'),),
                    
                            ],
                          ),
                    
                        ),
                        SizedBox(height: 50,),
                        Container(
                          padding: EdgeInsets.only(right: 30,left: 30),
                          child: Column(
                            children: [
                              TextField( cursorColor: Colors.black,style: TextStyle( fontFamily: 'sans-serif-light'),
                                controller: _emailController,
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
                              SizedBox(height: 20,),
                              TextField(style: TextStyle( fontFamily: 'sans-serif-light'),
                                controller: _passwordController,
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
                              SizedBox(width: 80,),
                              Text('                                            Forget Password?',style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'sans-serif-light'),textAlign: TextAlign.right,),

                              SizedBox(height: 30,),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.blueAccent, backgroundColor: Colors.blueAccent, // Set the text color here
                                  ),
                                  onPressed: _login,
                                  // Get.to(()=>MyHomePage());

                                  child: Text('Login',style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'sans-serif-medium'),),
                                ),
                              ),

                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 46,
                                    width: 300,
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
                      ],
                    ),
                  )
        );
  }}

//   void login(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? storedUsername = prefs.getString("username");
//     String? storedPassword = prefs.getString("password");
//     bool? isEmployee = prefs.getBool("isEmployee");
//
//     print(storedPassword);
//     print(storedUsername);
//     if (authController.usernameController.text == storedUsername && authController.passwordController.text == storedPassword) {
//       // Navigate to home screen
//       if(isEmployee??false){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//       }
//       else{
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//       }
//
//
//     }
//   }
// }


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
// }}