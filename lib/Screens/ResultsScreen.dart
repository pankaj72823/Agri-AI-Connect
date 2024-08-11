import 'package:agri_ai_connect/Screens/carbon_credits_marketplace.dart';
import 'package:agri_ai_connect/Screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Provider/result_provider.dart';
import '../Widgets/CarbonCredits/pie_chart_widget.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsyncValue = ref.watch(resultProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Your Carbon Credits Result'),
      ),
      body: resultAsyncValue.when(
        data: (result) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Carbon Credits: ${result.total}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: 1 + result.suggestions.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return PieChartWidget(result: result);
                      } else {
                        return ListTile(
                          leading: Icon(Icons.lightbulb),
                          title: Text(result.suggestions[index - 1]),
                        );
                      }
                    },
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context, MaterialPageRoute(
                        builder: (ctx) => CarbonCreditMarketplace(),
                      ),
          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent.withOpacity(0.8),
                        padding: EdgeInsets.all(15),
                        side: BorderSide(color: Colors.black, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),child: const Text('Carbon credit marketplace', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    ),

                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context, MaterialPageRoute(
                        builder: (ctx) => TabsScreen(),
                      ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent.withOpacity(0.8),
                        padding: EdgeInsets.all(15),
                        side: BorderSide(color: Colors.black, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),child: const Text('Home Screen ', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    ),

                    ),
                  ],
                )
              ],


            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
