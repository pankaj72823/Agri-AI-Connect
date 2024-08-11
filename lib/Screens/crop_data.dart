import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CropData extends StatefulWidget {
  @override
  _CropDataState createState() => _CropDataState();
}

class _CropDataState extends State<CropData> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController numberOfCropsController = TextEditingController();
  final TextEditingController typesOfCropsController = TextEditingController();
  final TextEditingController acresOfLandController = TextEditingController();

  String aiResponse = '';

  void sendRequest(String prompt) async {
    setState(() {
      aiResponse = 'Fetching response...';
    });

    final url = Uri.https('models3.p.rapidapi.com', '/');
    final queryParameters = {
      'model_id': '27',
      'prompt':
      'Given the location "${locationController.text}" and the types of crops "${typesOfCropsController.text}", evaluate if these crops are suitable for this location. If suitable, suggest ways to maximize benefits. If not suitable, suggest potential costs or alternative crops that could be grown successfully. Provide the answer in bullet points.',
    };
    final headers = {
      'Content-Type': 'application/json',
      'X-RapidAPI-Key': 'cddc497c61msha056b75bbe92f88p1c3834jsn007efcd6ece0',
      'X-RapidAPI-Host': 'models3.p.rapidapi.com',
    };
    final body = jsonEncode({
      'key1': 'value',
      'key2': 'value',
    });

    final response = await http.post(
        url.replace(queryParameters: queryParameters),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final botResponse = responseData['content'].replaceAll("\n", "");
      setState(() {
        aiResponse = botResponse;
      });
    } else {
      setState(() {
        aiResponse = 'Error fetching response';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Benefit Analysis'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/intial_img/cropdata.png',
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Crop Data',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: numberOfCropsController,
                      decoration: InputDecoration(
                        labelText: 'Number of Crops',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: typesOfCropsController,
                      decoration: InputDecoration(
                        labelText: 'Types of Crops',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: acresOfLandController,
                      decoration: InputDecoration(
                        labelText: 'Acres Of Land',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        String prompt =
                            'Location: ${locationController.text}, Number of Crops: ${numberOfCropsController.text}, Types of Crops: ${typesOfCropsController.text}, Acres Of Land: ${acresOfLandController.text}';
                        sendRequest(prompt);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Upload',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              if (aiResponse.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    aiResponse,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}