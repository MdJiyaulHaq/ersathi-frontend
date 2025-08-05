import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingPage1 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
        children: [
          Container(
            height: 390,
              child: Image.asset('assets/images/boarding1_image.png'),
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(21)
              )
            )
          ),
          Expanded(
            child: Container(

              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.purple,
                borderRadius: BorderRadius.circular(17)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 20),
                  Text("Learn the essentials", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),),
                  SizedBox(height: 20),
                  Text("Need to brush up your knowledge?", style: TextStyle(fontSize: 15,  color: Colors.white),),
                  Text("With our great learning resources,", style: TextStyle(fontSize: 15,  color: Colors.white),),
                  Text("you can learn everything you need to", style: TextStyle(fontSize: 15, color: Colors.white),),
                  Text("crack the License Exam", style: TextStyle(fontSize: 15, color: Colors.white),),

                ],

              ),


              ),
            ),
        ],
      );
  }
}