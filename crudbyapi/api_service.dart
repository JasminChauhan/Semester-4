import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://67c683da351c081993fd9532.mockapi.io/pract"; // Your MockAPI URL

  // Fetch Users (GET Request)
  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception("Failed to load users: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // Add User (POST Request)
  Future<void> insertUser(String name, String email) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"name": name, "email": email}),
      );

      if (response.statusCode != 201) {
        throw Exception("Failed to add user: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // Update User (PUT Request) - *ID should be String, not int*
  Future<void> updateUser(String id, String name, String email) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"name": name, "email": email}),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to update user: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // Delete User (DELETE Request) - *ID should be String, not int*
  Future<void> deleteUser(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"));

      if (response.statusCode != 200) {
        throw Exception("Failed to delete user: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}