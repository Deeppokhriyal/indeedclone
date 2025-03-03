import 'package:flutter/material.dart';
import 'package:indeed/login.dart';


class Starting extends StatefulWidget {
  const Starting({super.key});

  @override
  State<Starting> createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'starting page',
    );
  }
}
class MyStaringPage extends StatefulWidget {
  const MyStaringPage({super.key});

  @override
  _MyStaringPageState createState() => _MyStaringPageState();
}

class _MyStaringPageState extends State<MyStaringPage> {
  // State variable to keep track of the selected index

  // Method to handle item taps

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 15,left: 15,top: 40),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Image.asset('assets/images/officestart.png', height: 280,width: 400,alignment: Alignment.center,),
                ),
                Divider(color: Colors.black,),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Find Your', style: TextStyle(fontFamily: 'nexaheavy',fontWeight: FontWeight.bold,fontSize: 50, color: Colors.black),),
                      Text('Dream Job', style: TextStyle(fontFamily: 'nexaheavy',fontWeight: FontWeight.bold,fontSize: 50, color: Colors.blueAccent),),
                      Text('Here', style: TextStyle(fontFamily: 'nexaheavy',fontWeight: FontWeight.bold,fontSize: 50, color: Colors.black),),

                    ],
                  )
                ),
                 SizedBox(height: 15,),
                 Container(
                   child: Text('Explore all the most exciting jobs roles.\n'
                       'based on your intrest and study major.', style: TextStyle(fontFamily: 'nexalight',fontSize: 17, color: Colors.black),),
                 ),

                Divider(height: 30,color: Colors.black,),
                SizedBox(height: 30,),

                Container(
                  padding: EdgeInsets.only(right: 50,left: 50),
                  decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(35),border: Border.all(width: 6)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyLogin()));
                    },
                    child: Text('Let\'s start',style: TextStyle(fontSize: 20, color: Colors.blueAccent), // Customize text style
                    ),
                  ),
                )
              ],
            ),

          ]    ),
    );
  }
}