import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Disease {
  final String disease;
  final List<String> symptoms;
  final List<String> cure;
  final Pesticide pesticide;
  final Fertilizer fertilizer;
  final List<String> suggestions;

  Disease({
    required this.disease,
    required this.symptoms,
    required this.cure,
    required this.pesticide,
    required this.fertilizer,
    required this.suggestions,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      disease: json['disease'],
      symptoms: List<String>.from(json['symptoms']),
      cure: List<String>.from(json['cure']),
      pesticide: Pesticide.fromJson(json['pesticide']),
      fertilizer: Fertilizer.fromJson(json['fertilizer']),
      suggestions: List<String>.from(json['suggestions']),
    );
  }
}

class Pesticide {
  final String name;
  final String application;

  Pesticide({
    required this.name,
    required this.application,
  });

  factory Pesticide.fromJson(Map<String, dynamic> json) {
    return Pesticide(
      name: json['name'],
      application: json['application'],
    );
  }
}

class Fertilizer {
  final String name;
  final String application;

  Fertilizer({
    required this.name,
    required this.application,
  });

  factory Fertilizer.fromJson(Map<String, dynamic> json) {
    return Fertilizer(
      name: json['name'],
      application: json['application'],
    );
  }
}

final diseaseProvider = StateNotifierProvider<DiseaseNotifier, AsyncValue<Disease?>>((ref) {
  return DiseaseNotifier();
});

class DiseaseNotifier extends StateNotifier<AsyncValue<Disease?>> {
  DiseaseNotifier() : super(const AsyncValue.loading());

  // Method to upload the file and fetch the Disease data
  Future<void> uploadFile(BuildContext context, File file) async {
    state = const AsyncValue.loading();

    final disease = await _uploadFileToServer(context, file);
    if (disease != null) {
      state = AsyncValue.data(disease);
    } else{
      print('Failed to load data');
    }
  }
}

Future<Disease?> _uploadFileToServer(BuildContext context, File file) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://your-server-url/upload'),
  );
  request.files.add(await http.MultipartFile.fromPath('file', file.path));

  var response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    final jsonData = jsonDecode(responseData) as Map<String, dynamic>;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('File uploaded successfully!')),
    );
    return Disease.fromJson(jsonData);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('File upload failed with status: ${response.statusCode}'),
      ),
    );
    return null;
  }
}
