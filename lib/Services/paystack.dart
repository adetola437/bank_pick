import 'dart:convert';

import 'package:http/http.dart' as http;

class Paystack {
  late String code;
  Future<void> addCustomerToPaystack(
      String email, String name, String phone, String lastName) async {
    const url = 'https://api.paystack.co/customer';
    const apiKey =
        'sk_test_c272e944fa3171fc1f7d1e31b99a898cda7cb385'; // Replace with your Paystack API key

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final data = {
      'email': email,
      'first_name': name,
      'last_name': lastName,
      'phone': phone
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      // Customer added successfully
      // You can handle the success scenario based on your app's requirements
      print('Customer added to Paystack successfully');
    } else {
      // Customer addition failed
      // You can handle the failure scenario based on your app's requirements
      print('Failed to add customer to Paystack');
    }
  }

  Future<String> createTransferRecipient(String email, String name) async {
    final url = Uri.parse('https://api.paystack.co/transferrecipient');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'sk_test_c272e944fa3171fc1f7d1e31b99a898cda7cb385',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'type': 'email',
        'name': name,
        'email': email,
        'currency': 'NGN',
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final recipientCode = responseData['data']['recipient_code'];
      code = recipientCode;
      return recipientCode;
    } else {
      throw Exception('Failed to create transfer recipient');
    }
  }

  // Future<void> initiateTransfer(
  //     String recipientEmail, double amount, String description) async {
  //   const url = 'https://api.paystack.co/transfer';
  //   const apiKey =
  //       'sk_test_c272e944fa3171fc1f7d1e31b99a898cda7cb385'; // Replace with your Paystack API key

  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $apiKey',
  //   };

  //   final data = {
  //     'source': 'balance',
  //     'reason': description,
  //     'amount': amount.toInt() *
  //         100, // Paystack API expects amount in kobo (multiply by 100)
  //     'recipient': recipientEmail,
  //   };
  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         headers: headers, body: jsonEncode(data));
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       // Transfer initiated successfully
  //       // You can handle the success scenario based on your app's requirements
  //       print('Transfer initiated successfully');
  //     } else {
  //       // Transfer initiation failed
  //       // You can handle the failure scenario based on your app's requirements
  //       print('Transfer initiation failed');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<String> initiateTransfer(double amount, String description) async {
    final url = Uri.parse('https://api.paystack.co/transfer');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'sk_test_c272e944fa3171fc1f7d1e31b99a898cda7cb385',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'source': 'balance',
        'reason': description,
        'amount': amount.toInt() * 100, // Amount in kobo (1 NGN = 100 kobo)
        'recipient': code,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final transferCode = responseData['data']['transfer_code'];
      return transferCode;
    } else {
      print(response.body);
      throw Exception('Failed to initiate transfer');
    }
  }
}
