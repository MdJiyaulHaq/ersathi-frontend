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









//
// import 'package:flutter/material.dart';
//
// class OnBoardingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, // Number of onboarding pages
//       child: Scaffold(
//         body: TabBarView(
//           children: [
//             OnBoardingPage(
//               color: Colors.deepPurple,
//               title: "Learn the essentials",
//               description: [
//                 "Need to brush up your knowledge?",
//                 "With our great learning resources,",
//                 "you can learn everything you need to",
//                 "crack the License Exam",
//               ],
//             ),
//             OnBoardingPage(
//               color: Colors.blue,
//               title: "Test Your Knowledge",
//               description: [
//                 "Explore the largest repository of NEE",
//                 "Fine tune your test-taking skills",
//                 "with our most advanced resources",
//               ],
//             ),
//             OnBoardingPage(
//               color: Colors.green,
//               title: "Track Your Progress",
//               description: [
//                 "Monitor your improvement",
//                 "and stay motivated every day",
//               ],
//             ),
//           ],
//         ),
//         bottomNavigationBar: Container(
//           padding: EdgeInsets.all(16),
//           color: Colors.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TabPageSelector(), // Dots indicator
//               Builder(
//                 builder: (context) {
//                   return ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepPurple,
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                     ),
//                     onPressed: () {
//                       final controller =
//                       DefaultTabController.of(context); // get tab controller
//                       if (controller!.index < 2) {
//                         controller.animateTo(controller.index + 1);
//                       } else {
//                         // last page
//                         print("Onboarding Finished!");
//                       }
//                     },
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "Next",
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         SizedBox(width: 8),
//                         Icon(Icons.arrow_forward, color: Colors.white),
//                       ],
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class OnBoardingPage extends StatelessWidget {
//   final Color color;
//   final String title;
//   final List<String> description;
//
//   OnBoardingPage({
//     required this.color,
//     required this.title,
//     required this.description,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(height: 300, color: Colors.white),
//         Expanded(
//           child: Container(
//             color: color,
//             width: double.infinity,
//             padding: EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 SizedBox(height: 20),
//                 for (var line in description)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Text(line,
//                         style: TextStyle(fontSize: 15, color: Colors.white)),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
