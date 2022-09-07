import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkService {
  Future<List> getAllUser() async {
    try {
      var response = await Dio().get('https://dummyjson.com/users?limit=10');
      return response.data['users'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}
