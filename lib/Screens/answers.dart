import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agri_ai_connect/Provider/answers_provider.dart';
import 'package:agri_ai_connect/Widgets/CarbonCredits/answers_summary.dart';

class AnswersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(answersProvider);
    final carbonData = ref.watch(answersProvider.notifier).carbonData;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Answers Summary',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 8,
      ),
      body: answers.isEmpty
          ? Center(child: Text('No answers available'))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: AnswersSummary(
          answers: answers,
          carbonData: carbonData,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(answersProvider.notifier).submitAnswers();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Answers submitted')),
          );
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.send),
      ),
    );
  }
}
