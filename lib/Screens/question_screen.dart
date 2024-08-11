import 'package:agri_ai_connect/Screens/ResultsScreen.dart';
import 'package:agri_ai_connect/Widgets/DiseaseDetection/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Provider/answers_provider.dart';
import '../Provider/question_provider.dart';
import '../Widgets/CarbonCredits/question_card.dart';
import 'answers_screen.dart';


class QuestionsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsyncValue = ref.watch(questionsProvider);

    return Scaffold(

      body: questionsAsyncValue.when(
        data: (questions) {
          return SafeArea(
            child: Column(
              children: [
                Text('Calculate your Carbon Credits', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.teal),),
                Expanded(
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return QuestionsCard(
                        question: question,
                        isFinalQuestion: index == questions.length - 1,
                        category: question['category'],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await ref.read(answersProvider.notifier).submitAnswers();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ResultScreen()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to submit answers: $e')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Submit Answers', style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Failed to load questions: $error')),
      ),
    );
  }
}
