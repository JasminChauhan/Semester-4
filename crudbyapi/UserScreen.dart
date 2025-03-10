import 'package:flutter/material.dart';
import 'api_service.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> users = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  // Load users from API
  void loadUsers() async {
    try {
      final data = await apiService.getUsers();
      setState(() {
        users = data;
      });
    } catch (e) {
      print("Error loading users: $e");
    }
  }

  // Add or Update user
  void saveUser({String? id}) async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) return;

    try {
      if (id == null) {
        await apiService.insertUser(name, email);
      } else {
        await apiService.updateUser(id, name, email);
      }
      Navigator.pop(context);
      loadUsers();
    } catch (e) {
      print("Error saving user: $e");
    }

    nameController.clear();
    emailController.clear();
  }

  // Delete user
  void deleteUser(String id) async {
    try {
      await apiService.deleteUser(id);
      loadUsers();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  // Show Dialog for Add/Edit User
  void showUserDialog({String? id, String? existingName, String? existingEmail}) {
    if (id != null) {
      nameController.text = existingName ?? '';
      emailController.text = existingEmail ?? '';
    } else {
      nameController.clear();
      emailController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(id == null ? 'Add User' : 'Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(onPressed: () => saveUser(id: id), child: Text('Save'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API CRUD Example')),
      body: users.isEmpty
          ? Center(child: Text('No users found'))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name']),
            subtitle: Text(user['email']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => showUserDialog(
                    id: user['id'],  // Changed to String ID
                    existingName: user['name'],
                    existingEmail: user['email'],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteUser(user['id']), // Changed to String ID
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showUserDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}