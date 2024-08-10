import 'package:agri_ai_connect/Provider/disease_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Results extends ConsumerWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diseaseAsyncValue = ref.watch(diseaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Information'),
      ),
      body: diseaseAsyncValue.when(
        data: (disease) {
          if (disease == null) {
            return const Center(child: Text('No disease data available.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'Detected Disease',
                  content: disease.disease,
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'Symptoms',
                  content: disease.symptoms.join('\n'),
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'Cure',
                  content: disease.cure.join('\n'),
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'Pesticide',
                  content:
                      '${disease.pesticide.name}\nApplication: ${disease.pesticide.application}',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'Fertilizer',
                  content:
                      '${disease.fertilizer.name}\nApplication: ${disease.fertilizer.application}',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'Suggestions',
                  content: disease.suggestions.join('\n'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
