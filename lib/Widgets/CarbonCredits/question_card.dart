import 'package:agri_ai_connect/Provider/answers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsCard extends ConsumerStatefulWidget {
  QuestionsCard({super.key,
    required this.question,
    required this.isFinalQuestion,
    required this.category,
  });

  final Map<String, dynamic> question;
  final bool isFinalQuestion;
  final String category;

  @override
  ConsumerState<QuestionsCard> createState() {
    return _QuestionsCard();
  }
}

class _QuestionsCard extends ConsumerState<QuestionsCard> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Colors.teal,
            width: 2,
          ),
        ),
        elevation: 8,
        shadowColor: Colors.tealAccent.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.question['question'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 16),
              if (widget.question['options'].isNotEmpty)
                Column(
                  children: widget.question['options'].map<Widget>((option) {
                    return ListTile(
                      title: Text(option),
                      leading: Checkbox(
                        value: selectedOption == option,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = option;
                          });
                          ref.read(answersProvider.notifier).addAnswer(
                            widget.question['question'], option,
                          );
                        },
                        activeColor: Colors.teal,
                      ),
                    );
                  }).toList(),
                )
              else
                TextField(
                  onChanged: (value) {
                    ref.read(answersProvider.notifier).addAnswer(
                      widget.question['question'], value,
                    );
                  },
                  decoration: InputDecoration(
                    labelText: 'Type your answer here',
                    labelStyle: TextStyle(color: Colors.teal.shade700),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
