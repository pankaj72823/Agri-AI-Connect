import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Provider/profile_data_provider.dart';  // Ensure the correct path

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiledetailsAsyncValue = ref.watch(userCarbonCreditsProvider);

    return profiledetailsAsyncValue.when(
      data: (profiledetails) {
        // Print the fetched data
        print('Name: ${profiledetails.name}');
        print('Phone Number: ${profiledetails.phoneNumber}');
        print('Address: ${profiledetails.address}');
        print('Total Carbon Credits: ${profiledetails.totalCarbonCredits}');

        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(profiledetails.name),
                  accountEmail: Text(profiledetails.address), // Assuming address acts as email or location
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/splash/splash.jpg'), // Update with your image path
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Mobile Number'),
                  subtitle: Text('${profiledetails.phoneNumber}'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Location'),
                  subtitle: Text(profiledetails.address),
                ),
                ListTile(
                  leading: Icon(Icons.eco),
                  title: Text('Carbon Credits'),
                  subtitle: Text('${profiledetails.totalCarbonCredits}'),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
