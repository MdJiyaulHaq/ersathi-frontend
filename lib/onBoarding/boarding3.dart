import 'package:flutter/material.dart';

class OnBoardingPage3 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Container(
          height: 390,
          color: Colors.white,
          child: Image.asset("assets/images/student.png")
        ),
        Expanded(
            child:Container(

              width: double.infinity,
              padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(17)
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Track your Progress", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 20,),
                  Text("Monitor your improvement", style: TextStyle(fontSize: 12, color: Colors.white),),
                  Text("and stay motivated every day",
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ],
              )
            ) )
      ],
    );
  }
}