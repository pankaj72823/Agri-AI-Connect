// import 'package:agri_ai_connect/Provider/answers_provider.dart';
// import 'package:agri_ai_connect/Screens/answers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:agri_ai_connect/Provider/questions_provider.dart';
// import 'package:agri_ai_connect/Widgets/CarbonCredits/questions_card.dart';
//
// class QuestionsScreen extends ConsumerWidget {
//   const QuestionsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final questionsAsyncValue = ref.watch(questionsProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Questions',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//           ),
//         ),
//         backgroundColor: Colors.teal,
//         elevation: 8,
//       ),
//       body: questionsAsyncValue.when(
//         loading: () => Center(
//           child: LinearProgressIndicator(
//             backgroundColor: Colors.blue,
//             borderRadius: BorderRadius.circular(10),
//             minHeight: 20,
//           ),
//         ),
//         error: (error, stack) => Center(
//           child: Text('Failed to load questions'),
//         ),
//         data: (questions) {
//           return Container(
//             height: double.infinity,
//             width: double.infinity,
//             child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                     itemCount: questions.length,
//                     itemBuilder: (context, index) {
//                       final question = questions[index];
//                       final isFinalQuestion = index == questions.length - 1;
//                       return QuestionsCard(
//                         question: question,
//                         isFinalQuestion: isFinalQuestion,
//                         category: question['category'],
//                       );
//                     },
//                                     ),
//                   ),
//                   ElevatedButton(onPressed: () async {
//                        await Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (ctx) => AnswersScreen()
//                         ),
//
//                       );
//                       ref.read(answersProvider.notifier).submitAnswers();
//                   },
//                   child: Text('Generate Carbon Credits'),
//                   ),
//
//               ],
//               ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// extension on Map<String, dynamic> {
//   when({required Center Function() loading, required Center Function(dynamic error, dynamic stack) error, required Container Function(dynamic questions) data}) {}
// }
//
