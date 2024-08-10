import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agri_ai_connect/Provider/questions_provider.dart';
import 'package:agri_ai_connect/Widgets/CarbonCredits/questions_card.dart';

class QuestionsScreen extends ConsumerWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsyncValue = ref.watch(questionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Questions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 8,
      ),
      body: questionsAsyncValue.when(
        loading: () => Center(
          child: LinearProgressIndicator(
            backgroundColor: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            minHeight: 20,
          ),
        ),
        error: (error, stack) => Center(
          child: Text('Failed to load questions'),
        ),
        data: (questions) {
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              final isFinalQuestion = index == questions.length - 1;
              return QuestionsCard(
                question: question,
                isFinalQuestion: isFinalQuestion,
                category: question['category'],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(questionnaireProvider.notifier).submitAnswers();
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
