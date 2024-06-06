import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/user_model.dart';

class ApiServices {
  final String endpoint = 'https://651f072d44a3a8aa476958b6.mockapi.io/product';

  Future<List<UserModel>> getUser() async {
    var response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);

      // Chuyển đổi danh sách dữ liệu từ JSON sang danh sách UserModel.
      List<UserModel> users = dataList.map((dynamic item) {
        return UserModel.fromJson(item);
      }).toList();

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$endpoint/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}

final userProvider = FutureProvider<List<UserModel>>((ref) async {
  return ApiServices().getUser();
});
