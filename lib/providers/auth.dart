import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA0CfbE78weRYtcPpg3C8WQKNY3KYgA9Rg';

    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
  }

  Future<void> Signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> Login(String email, String password) async {
   return _authenticate(email, password, 'signInWithPassword');
  }
    
}