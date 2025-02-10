import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homepage.dart';
class AppliedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/applied.png'),
            Text('No jobs saved yet'),
            SizedBox(height: 5,),
            Text('Jobs you save appear here.'),
            SizedBox(height: 15,),
            Text('Not seeing a job?'),
            SizedBox(height: 15,),
        
            ElevatedButton(
              onPressed: (){
                Get.to(MyHomePage());
              },
        
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Text color
              ),
              child: Row(
                children: [
                  Text('Find jobs',style: TextStyle(color: Colors.white,fontFamily: 'nexalight'),),
                  Icon(Icons.arrow_forward,color: Colors.white,),
                ],
              ),)
        
          ],
        ),
        
        
            ),
      );
  }
}