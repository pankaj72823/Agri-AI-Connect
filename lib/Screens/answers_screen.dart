// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../Provider/answers_provider.dart';
//
// class AnswersScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final answers = ref.watch(answersProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Submitted Answers'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: answers.length,
//           itemBuilder: (context, index) {
//             final question = answers.keys.elementAt(index);
//             final answer = answers[question];
//             return ListTile(
//               title: Text(question),
//               subtitle: Text(answer as String),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
