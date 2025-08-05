import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:er_sathi/onBoarding/boarding1.dart';
import 'package:er_sathi/onBoarding/boarding2.dart';
import 'package:er_sathi/onBoarding/boarding3.dart';

class OnBoardingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
            children: [
              OnBoardingPage1(),
              OnBoardingPage2(),
              OnBoardingPage3(),
            ],),

        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabPageSelector(),
              Builder(
                builder: (context){
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20)
                    ),
                  onPressed: (){
                    final controller = DefaultTabController.of(context);
                    if(controller!.index <2 ){
                      controller.animateTo(controller.index +1);
                    }
                    else{
                      print("OnBoarding Finished!");
                    }
                  }, child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ],
                  ));
                },
              )
            ],
          )
        ),
      ),
    );
  }
}