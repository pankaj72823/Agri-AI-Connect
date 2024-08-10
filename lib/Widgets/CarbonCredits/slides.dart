import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agri_ai_connect/Widgets/CarbonCredits/questions_card.dart';

import '../../Provider/questions_provider.dart';

class Slides extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsyncValue = ref.watch(questionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: questionsAsyncValue.when(
        data: (questions) {
          return PageView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              final isFinalQuestion = index == questions.length - 1;
              final category = question['category'];

              return QuestionsCard(
                question: question,
                isFinalQuestion: isFinalQuestion,
                category: category,
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Failed to load questions')),
      ),
    );
  }
}
