import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:agri_ai_connect/Screens/tabs_screen.dart';

class Signup extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Signup();
}

class _Signup extends ConsumerState<Signup> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  String? gender;
  bool passwordVisible = false;
  List<String> selectedCrops = [];

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    addressController.dispose();
    pincodeController.dispose();
  }

  Future<void> _signup() async {
    if (formKey.currentState?.validate() ?? false) {
      final name = nameController.text;
      final email = emailController.text;
      final phone_number = phoneNumberController.text;
      final username = usernameController.text;
      final password = passwordController.text;
      final address = addressController.text;
      final pincode = pincodeController.text;

      final response = await http.post(
        Uri.parse("http://localhost:5050/auth/signup"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone_number': phone_number,
          'username': username,
          'password': password,
          'gender': gender,
          'address': address,
          'pincode': pincode,
          'crops': selectedCrops,
        }),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        print(token);
        print("Sign up Successful");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => TabsScreen()),
        );
      } else {
        print("There is an error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/splash/background.jpg', // Use the path to your image file here
              fit: BoxFit.cover,
            ),
          ),
          // Transparent Overlay with Scrollable Form
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Your Account',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: nameController,
                          labelText: 'Full Name',
                          icon: Icons.person,
                          validatorMessage: 'Please enter your Name',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: emailController,
                          labelText: 'Email',
                          icon: Icons.email,
                          validatorMessage: 'Please enter your Email',
                        ),
                        const SizedBox(height: 16),
                        _buildPhoneField(),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: usernameController,
                          labelText: 'Username',
                          icon: Icons.person_outline,
                          validatorMessage: 'Please enter your Username',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: passwordController,
                          labelText: 'Password',
                          icon: Icons.lock_outline,
                          validatorMessage: 'Please enter your Password',
                          obscureText: !passwordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdownField(),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: addressController,
                          labelText: 'Address',
                          icon: Icons.home_outlined,
                          validatorMessage: 'Please enter your Address',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: pincodeController,
                          labelText: 'Pincode',
                          icon: Icons.pin_drop_outlined,
                          validatorMessage: 'Please enter your Pincode',
                        ),
                        const SizedBox(height: 16),
                        _buildCropsSelection(),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _signup,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widgets remain the same...
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required String validatorMessage,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Colors.teal),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMessage;
          }
          return null;
        },
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: IntlPhoneField(
        controller: phoneNumberController,
        decoration: InputDecoration(
          labelText: 'Phone Number',
          prefixIcon: Icon(Icons.phone, color: Colors.teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        initialCountryCode: 'US',
        onChanged: (phone) {},
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        value: gender,
        items: ['Male', 'Female', 'Other']
            .map((label) => DropdownMenuItem(
          child: Text(label),
          value: label,
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            gender = value;
          });
        },
        validator: (value) => value == null ? 'Please select your Gender' : null,
      ),
    );
  }

  Widget _buildCropsSelection() {
    final crops = ['Rice', 'Wheat', 'Corn']; // Example crops
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Types of Crops:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0), // Add some spacing between the label and the chips
        Wrap(
          spacing: 8.0,
          children: crops.map((crop) {
            return ChoiceChip(
              label: Text(crop),
              selected: selectedCrops.contains(crop),
              onSelected: (isSelected) {
                setState(() {
                  if (isSelected) {
                    selectedCrops.add(crop);
                  } else {
                    selectedCrops.remove(crop);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  }
