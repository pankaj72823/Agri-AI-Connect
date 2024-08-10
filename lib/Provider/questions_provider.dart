import 'package:agri_ai_connect/Provider/token_provider.dart';
import 'package:agri_ai_connect/Screens/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final questionsProvider = FutureProvider<List<dynamic>>((ref) async {
  final response = await http.get(Uri.parse('http://192.168.173.164:5050/question'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load questions');
  }
});


final questionnaireProvider = StateNotifierProvider<QuestionnaireNotifier, Map<String, dynamic>>((ref) {
  return QuestionnaireNotifier();
});

class QuestionnaireNotifier extends StateNotifier<Map<String, dynamic>> {
  QuestionnaireNotifier() : super({});

  void addAnswer(String question, dynamic answer) {
    state = {
      ...state,
      question: answer,
    };
  }

    //
    // Future<void> submitAnswers() async {
    //
    //   final token = ref.watch(userTokenProvider)
    //   final response = await http.post(
    //     Uri.parse('http://localhost:5050/answers'),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(<String, dynamic>{
    //       'token': _token,
    //       'data': state,
    //     }),
    //   );
    //
    //   if (response.statusCode == 200) {
    //     print("Successful");
    //
    //   } else {
    //     print("Error is there");
    //   }
    // }
  Future<void> submitAnswers() async {



    final response = await http.post(
      Uri.parse('http://localhost:5050/answers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'data': state,
      }),
    );

    if (response.statusCode == 200) {
      print("Successful");
    } else {
      print("Error: ${response.statusCode}");
    }
  }

}

