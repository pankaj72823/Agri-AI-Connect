import 'dart:io';
import 'package:agri_ai_connect/Provider/disease_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agri_ai_connect/Widgets/DiseaseDetection/results.dart';

class DiseaseDetectionScreen extends ConsumerStatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  _DiseaseDetectionScreenState createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends ConsumerState<DiseaseDetectionScreen> {
  double _opacity = 0.0;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  Future<void> _captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      // Upload the image and fetch disease details
      await ref.read(diseaseProvider.notifier).uploadFile(context, _image!);

      // Navigate to the Results screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Results()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                'AI Crop Disease Detection',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'Upload a photo of your crop or capture a new one to detect diseases.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () async {
                  await _captureImage();
                  _uploadImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                label: const Text(
                  'Capture with Camera',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Or",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () async {
                  await _uploadImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                icon: const Icon(Icons.photo, color: Colors.white),
                label: const Text(
                  'Upload from Gallery',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              if (_image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.file(
                      _image!,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/splash/splash.jpg',
                      height: 200,
                      fit: BoxFit.cover,
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
