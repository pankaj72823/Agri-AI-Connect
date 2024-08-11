import 'package:agri_ai_connect/Provider/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final resultProvider = FutureProvider<ResultData>((ref) async {
  final token = ref.watch(userTokenProvider);

  if (token == null) {
    throw Exception('Token is not available');
  }

  final response = await http.post(
    Uri.parse('http://192.168.173.164:5050/answers/result'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'token': token,
    }),
  );

  if (response.statusCode == 200) {
    return ResultData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load result data');
  }
});

class ResultData {
  final double cropManagement;
  final double soilManagement;
  final double waterUsage;
  final double energyUse;
  final double wasteManagement;
  final double total;
  final List<String> suggestions;

  ResultData({
    required this.cropManagement,
    required this.soilManagement,
    required this.waterUsage,
    required this.energyUse,
    required this.wasteManagement,
    required this.total,
    required this.suggestions,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) {
    return ResultData(
      cropManagement: double.parse(json['Crop_Management']),
      soilManagement: double.parse(json['Soil_Management']),
      waterUsage: double.parse(json['Water_Usage']),
      energyUse: double.parse(json['Energy_Use']),
      wasteManagement: double.parse(json['Waste_Management']),
      total: double.parse(json['total']),
      suggestions: List<String>.from(json['suggestions']),
    );
  }
}
