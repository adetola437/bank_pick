import 'dart:convert';

import 'package:http/http.dart' as http;

class FlutterWave {
  Future<void> addFlutterwaveCustomer(
      String name, String phone, String email) async {
    // Replace with your Flutterwave API base URL
    const String baseUrl = 'https://api.flutterwave.com';

    // Replace with your Flutterwave API key
    const String apiKey = 'FLWSECK_TEST-96463c4677e00a8f8fe7f5191b17a1b4-X';

    // Create the request body with customer details
    final Map<String, dynamic> requestBody = {
      'name': name,
      'email': email,
      'phone_number': phone,
      'metadata': {
        'custom_fields': [
          {
            'display_name': 'Membership Level',
            'variable_name': 'membership_level',
            'value': 'Gold',
          },
          // Add more custom fields if needed
        ],
      },
    };

    const String url = '$baseUrl/customers';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        // Customer added successfully
        print('Customer added successfully');
      } else {
        // Error adding customer
        print('Error adding customer: ${response.body}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception adding customer: $e');
    }
  }
}
