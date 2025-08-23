import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingPage2 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
          children: [
            Container(
              height: 390,
                child: Image.asset("assets/images/student.png"),
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
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(17)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(height: 20),
                    Text("Test Your Knowledge", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),),
                    SizedBox(height: 20),
                    Text("Explore the largest repositary of NEE", style: TextStyle(fontSize: 15,  color: Colors.white),),
                    Text("Fine tune your test-taking skills", style: TextStyle(fontSize: 15,  color: Colors.white),),
                    Text("with our most advanced resouces", style: TextStyle(fontSize: 15, color: Colors.white),),
                    Text("crack the License Exam", style: TextStyle(fontSize: 15, color: Colors.white),),
                  ]
                ),
              ),
            )
          ],
        );
  }
}