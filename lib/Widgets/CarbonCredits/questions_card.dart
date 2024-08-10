import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Provider/questions_provider.dart';

class QuestionsCard extends ConsumerStatefulWidget {
  const QuestionsCard({
    required this.question,
    required this.isFinalQuestion,
    required this.category,
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> question;
  final bool isFinalQuestion;
  final String category;

  @override
  ConsumerState<QuestionsCard> createState() => _QuestionsCardState();
}

class _QuestionsCardState extends ConsumerState<QuestionsCard> {
  String? selectedOption;
  TextEditingController? _textEditingController;

  @override
  void initState() {
    super.initState();
    if (widget.question['type'] == 'text') {
      _textEditingController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionType = widget.question['type'];
    final options = widget.question['options'] as List<dynamic>?;

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
              const SizedBox(height: 16),
              if (questionType == 'single' && options != null)
                ...options.map<Widget>((option) {
                  return ListTile(
                    title: Text(option.toString()),
                    leading: Radio<String>(
                      value: option.toString(),
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                        ref.read(questionnaireProvider.notifier).addAnswer(
                          widget.question['question'], value!,
                        );
                      },
                      activeColor: Colors.teal,
                    ),
                  );
                }).toList()
              else if (questionType == 'multiple' && options != null)
                ...options.map<Widget>((option) {
                  return ListTile(
                    title: Text(option.toString()),
                    leading: Checkbox(
                      value: selectedOption == option,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = option.toString();
                        });
                        ref.read(questionnaireProvider.notifier).addAnswer(
                          widget.question['question'], option.toString(),
                        );
                      },
                      activeColor: Colors.teal,
                    ),
                  );
                }).toList()
              else if (questionType == 'text')
                  TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      ref.read(questionnaireProvider.notifier).addAnswer(
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
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
