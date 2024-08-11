import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define the Question model
class Question {
  final String question;
  final String type;
  final List<String> options;
  final String category;

  Question({
    required this.question,
    required this.type,
    required this.options,
    required this.category,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      type: json['type'],
      options: List<String>.from(json['options']),
      category: json['category'],
    );
  }
}

// Define the QuestionService
class QuestionService {
  final String apiUrl = 'http://192.168.173.164:5050/question'; // Replace with your actual API endpoint

  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Question.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}

// Define the providers
final questionServiceProvider = Provider((ref) => QuestionService());

final questionsProvider = FutureProvider<List<Question>>((ref) async {
  final questionService = ref.read(questionServiceProvider);
  return await questionService.fetchQuestions();
});
