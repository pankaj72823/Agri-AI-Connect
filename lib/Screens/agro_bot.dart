import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WellnessWizardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellness Wizard',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Color(0xFFE8F5E9),
        textTheme: TextTheme(bodyMedium: TextStyle(color: Color(0xFF2E7D32))),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF37474F),
        scaffoldBackgroundColor: Color(0xFF263238),
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      themeMode: ThemeMode.system, // Default to system theme
      home: AgroBotScreen(),
    );
  }
}

class AgroBotScreen extends StatefulWidget {
  @override
  _AgroBotState createState() => _AgroBotState();
}

class _AgroBotState extends State<AgroBotScreen> {
  final List<Map<String, String>> chatHistory = [];
  final TextEditingController promptController = TextEditingController();
  bool isDarkMode = false;

  void sendRequest(String prompt) async {
    setState(() {
      chatHistory.add({'user': prompt});
    });

    final url = Uri.https('models3.p.rapidapi.com', '/');
    final queryParameters = {
      'model_id': '27',
      'prompt':
      'Only answers Agriculture related questions otherwise reply with "I don\'t know": $prompt',
      // Ask for Hindi response
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
        chatHistory.add({'bot': botResponse});
      });
    } else {
      setState(() {
        chatHistory.add({'bot': 'Error fetching response'});
      });
    }

    promptController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agro Bot'),
        backgroundColor: Colors.teal[200],
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  final message = chatHistory[index];
                  final isUser = message.containsKey('user');
                  return Align(
                    alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.green : Colors.lightGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isUser ? message['user']! : message['bot']!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: promptController,
              decoration: InputDecoration(
                hintText: 'Enter your message here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (promptController.text.isNotEmpty) {
                      sendRequest(promptController.text);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}