import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_comtroller.dart';


class MySignUpPage extends StatefulWidget {
  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}
class _MySignUpPageState extends State<MySignUpPage> {
  final AuthController authController = Get.find(tag: "Login");
  // final SignupController controller=Get.put(tag: 'SignupController',SignupController());
  // TextEditingController usernameController=TextEditingController();
  // TextEditingController passwordController=TextEditingController();
  // bool _isChecked = false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body:  Stack(
        children:[ Container(
            margin: EdgeInsets.fromLTRB(13, 50, 300, 20),
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,size: 35,)),
        ),
      Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.13,left: 23),
        child: Column(
          children: [
            Text('Welcome !\nCreate an Account', style: TextStyle( color: Colors.black, fontSize: 38, fontFamily: 'nexalight'),),
            Text('Create an account & start your career search',style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'nexalight'),),
          ],
        ),
      ),
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25,right: 30,left: 30),
          child: Column(
            children: [
              Text(''),
              SizedBox(height: 40,),
              TextField(
                controller: authController.usernameController,
                cursorColor: Colors.black,style: TextStyle( fontFamily: 'sans-serif-light'),
                decoration: InputDecoration(
                  fillColor: Colors.pink,
                  hintText: 'Enter your Name',
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
                cursorColor: Colors.black,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  hintText: 'Enter your Email',
                  border: OutlineInputBorder( // Unfocused border color
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
                controller: authController.passwordController,
                obscureText: true,
                cursorColor: Colors.black,
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
        
                Obx(
                  ()=> CheckboxListTile(
                      value:authController.isChecked.value,
                      onChanged: (value) {
                        authController.isChecked.value = value!;
                      },
                    activeColor: Colors.green,
                      title: Text('As Employer',style: TextStyle(fontFamily: 'sans-serif-thin',fontSize: 13),),
                    ),
                ),
        
              SizedBox(height: 30,),
              SizedBox(
                height: 50,
                width: double.infinity, // Full width
                child: ElevatedButton(
                  onPressed: () => authController.signup(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Set background color to black
                    padding: EdgeInsets.symmetric(vertical: 15), // Button height
                    textStyle: TextStyle(fontSize: 18, ), // Font size
                  ),
                  child: Text('Sign up',style: TextStyle(color: Colors.white,fontFamily: 'sans-serif-medium'),),
                ),
              ),
        
              SizedBox(height: 39,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 46,
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.white70, // Set the text color here
                          ),  onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MySignUpPage(),),
                          );
                        },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/google.png', height: 29,),
                              SizedBox(width: 20,),
                              Text('Sign in with Google',style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: 'nexalight'),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already Have an Account?', style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'sans-serif-light'),),
                  SizedBox(width: 50,),
        
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text('Log in',style: TextStyle(color: Colors.blueAccent),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ]
    ),
    );
  }}

//   void signup(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString("username", authController.usernameController.text);
//     await prefs.setString("password", authController.passwordController.text);
//     await prefs.setBool("isEmployee", authController.isChecked.value);
//     // Navigate back to login screen
//     Navigator.pop(context);
//   }
// }

