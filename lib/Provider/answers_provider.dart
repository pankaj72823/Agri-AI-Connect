import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class AnswersNotifier extends StateNotifier<List<Map<String, String>>> {
  AnswersNotifier() : super([]);

  String? _token;
  void setToken(String token){
    _token = token;
  }

  void addAnswer(String question, String answer) {
     state = [
      for (final answer in state)
        if (answer['question'] != question) answer,
      {'question': question, 'answer': answer},
    ];
  }

  Future<void> submitAnswers() async {
    final response = await http.post(
      Uri.parse('http://192.168.173.164:5050/answers'),
      headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'token': _token,
          'data': state,
        }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit answers');
    }
  }

  void clearAnswers() {
    state = [];
  }
}


final answersProvider = StateNotifierProvider<AnswersNotifier, List<Map<String, String>>>((ref) {
  return AnswersNotifier();
});
