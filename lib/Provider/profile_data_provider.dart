import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:agri_ai_connect/Provider/token_provider.dart'; // Ensure this path is correct

final userCarbonCreditsProvider = FutureProvider<UserCarbonCredits>((ref) async {
  final token = ref.watch(userTokenProvider);

  if (token == null) {
    throw Exception('Token is not available');
  }

  final response = await http.post(
    Uri.parse('http://192.168.173.164:5050/user'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'token': token,
    }),
  );

  if (response.statusCode == 200) {
    return UserCarbonCredits.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user carbon credits');
  }
});

class UserCarbonCredits {
  final String name;
  final int phoneNumber;
  final String address;
  final double totalCarbonCredits;

  UserCarbonCredits({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.totalCarbonCredits,
  });

  factory UserCarbonCredits.fromJson(Map<String, dynamic> json) {
    return UserCarbonCredits(
      name: json['name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      totalCarbonCredits: double.parse(json['carbon_credits']['total'].toString()),
    );
  }
}
