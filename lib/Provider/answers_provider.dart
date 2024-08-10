import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnswersProvider extends StateNotifier<List<Map<String, dynamic>>> {
  AnswersProvider() : super([]);
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  void addAnswer(String question, dynamic answer) {
    state = [
      for (final answer in state)
        if (answer['question'] != question) answer,
      {'question': question, 'answer': answer},
    ];
  }

  Future<void> submitAnswers() async {
    final response = await http.post(
      Uri.parse('http://l192.168.173.164:5050/answers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'token': _token,
        'data': state,
      }),
    );

    if (response.statusCode == 200) {
      print("Successful");
    } else {
      print("Error is there");
    }
  }

  // Dummy data for pie chart
  Map<String, double> get carbonData => {
    "Transportation": 30,
    "Home Energy Use": 25,
    "Diet": 20,
    "Waste Management": 15,
    "Other": 10,
  };
}

final answersProvider = StateNotifierProvider<AnswersProvider, List<Map<String, dynamic>>>(
      (ref) => AnswersProvider(),
);
