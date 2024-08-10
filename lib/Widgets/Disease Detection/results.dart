import 'package:agri_ai_connect/Provider/disease_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Results extends ConsumerWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diseaseAsyncValue = ref.watch(diseaseProvider);

    return diseaseAsyncValue.when(
      data: (disease) {
        if (disease == null) {
          return Center(child: Text('No disease data available.'));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Detected Disease Section
              _buildSection(
                title: 'Detected Disease',
                content: disease.disease,
              ),
              SizedBox(height: 20),

              // Symptoms Section
              _buildSection(
                title: 'Symptoms',
                content: disease.symptoms.join('\n'),
              ),
              SizedBox(height: 20),

              // Cure Section
              _buildSection(
                title: 'Cure',
                content: disease.cure.join('\n'),
              ),
              SizedBox(height: 20),

              // Pesticide Section
              _buildSection(
                title: 'Pesticide',
                content: '${disease.pesticide.name}\nApplication: ${disease.pesticide.application}',
              ),
              SizedBox(height: 20),

              // Fertilizer Section
              _buildSection(
                title: 'Fertilizer',
                content: '${disease.fertilizer.name}\nApplication: ${disease.fertilizer.application}',
              ),
              SizedBox(height: 20),

              // Suggestions Section
              _buildSection(
                title: 'Suggestions',
                content: disease.suggestions.join('\n'),
              ),
            ],
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
