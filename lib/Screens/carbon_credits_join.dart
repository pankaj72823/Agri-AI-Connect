import 'package:agri_ai_connect/Screens/carbon_credits_marketplace.dart';
import 'package:agri_ai_connect/Screens/question_screen.dart';
// import 'package:agri_ai_connect/Screens/question_screen.dart';
import 'package:flutter/material.dart';

class CarbonCreditsJoin extends StatelessWidget{
  const CarbonCreditsJoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Text(
            'Marketplace',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.teal[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Image.asset('assets/carboncredits/carbon.jpeg'),
          const SizedBox(height: 20,),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 220),
            child: Text(
              'Your carbon credits will be calculated based on different parameters',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: ()=>  Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => QuestionsScreen(),),
          ),
            style: ElevatedButton.styleFrom(
              side: BorderSide(width: 2 , color: Colors.black),
              backgroundColor: Colors.orange, // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
              child:Text(' Join the Carbon Credits Market ', style: TextStyle(color: Colors.white, fontSize: 20),),
          ),


        ],
      ),
    );
  }
  
}