import 'package:flutter/material.dart';

import 'package:agri_ai_connect/Widgets/CarbonCredits/buyer_card_widget.dart';
import 'package:agri_ai_connect/Widgets/CarbonCredits/userProfile.dart';


class CarbonCreditMarketplace extends StatelessWidget {
  const CarbonCreditMarketplace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Carbon Credits Marketplace',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const UserProfileWidget(
                  name: 'John Smith',
                  role: 'Farmer',
                  credits: 250,
                  ratePerCredit: 5000.00,
                  imagePath: 'assets/splash/background.jpg', // Replace with actual path
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.business),
                    Text(
                      'Interested Buyers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                BuyerCardWidget(
                  companyName: 'Eco Corp',
                  role: 'Carbon Offset Buyer',
                  imagePath: 'assets/splash/splash.jpg', // Replace with actual path
                  onPressed: () {
                  },
                ),
                SizedBox(height: 10),
                BuyerCardWidget(
                  companyName: 'Green Solutions',
                  role: 'Carbon Offset Buyer',
                  imagePath: 'assets/splash/splash.jpg', // Replace with actual path
                  onPressed: () {
                    // Handle button press
                  },
                ),
                SizedBox(height: 10),
                BuyerCardWidget(
                  companyName: 'Carbon Offset Inc.',
                  role: 'Carbon Offset Buyer',
                  imagePath: 'assets/splash/splash.jpg', // Replace with actual path
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


