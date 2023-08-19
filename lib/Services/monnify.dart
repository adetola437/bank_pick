import 'dart:convert';

import 'package:http/http.dart' as http;

class Monnify {
  Future<void> createMonnifyCustomer(
      String name, String phone, String email) async {
    // Replace with your Monnify API base URL
    const String baseUrl = 'https://sandbox.monnify.com';

    // Replace with your Monnify API key
    const String apiKey = 'MK_TEST_G8H2CP0KMW';

    // Create the request body with customer details
    final Map<String, dynamic> requestBody = {
      'customerEmail': email,
      'customerName': name,
      'customerPhoneNumber': phone,
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
        // Customer created successfully
        print('Customer created successfully');
      } else {
        // Error creating customer
        print('Error creating customer: ${response.body}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception creating customer: $e');
    }
  }
}
