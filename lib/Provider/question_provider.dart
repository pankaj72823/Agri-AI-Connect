import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define a provider to fetch questions from the backend
final questionsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final response = await http.get(Uri.parse('http://192.168.173.164:5050/question'));

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> questions = List<Map<String, dynamic>>.from(
        json.decode(response.body)
    );
    return questions;
  } else {
    throw Exception('Failed to load questions');
  }
});
