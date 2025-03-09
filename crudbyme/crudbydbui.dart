import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'crudbydb.dart';

class Crudbydbui extends StatefulWidget {
  const Crudbydbui({super.key});

  @override
  State<Crudbydbui> createState() => _CrudbydbuiState();
}

class _CrudbydbuiState extends State<Crudbydbui> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  List<Map<String, dynamic>> userList = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    final users = await DatabaseHelper.instance.fetchUsers();
    if (mounted) {
      setState(() {
        userList = users;
      });
    }
  }

  void _addUser() async {
    if (namecontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty) {
      await DatabaseHelper.instance.insertUser({
        'name': namecontroller.text,
        'email': emailcontroller.text,
      });
      namecontroller.clear();
      emailcontroller.clear();
      _fetchUsers();
    }
  }

  void _updateUser(int id) {
    namecontroller.text = userList.firstWhere((user) => user['id'] == id)['name'];
    emailcontroller.text = userList.firstWhere((user) => user['id'] == id)['email'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update User"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: namecontroller,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailcontroller,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (namecontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty) {
                  await DatabaseHelper.instance.updateUser({
                    'id': id,
                    'name': namecontroller.text,
                    'email': emailcontroller.text,
                  });
                  namecontroller.clear();
                  emailcontroller.clear();
                  _fetchUsers();
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id);
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Management")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: userList.isEmpty
            ? const Center(child: Text("No users found"))
            : ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(userList[index]['name']),
                subtitle: Text(userList[index]['email']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          _updateUser(userList[index]['id']);
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          _deleteUser(userList[index]['id']);
                        },
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          namecontroller.clear();
          emailcontroller.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add User"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: namecontroller,
                        decoration: const InputDecoration(labelText: "Name"),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: emailcontroller,
                        decoration: const InputDecoration(labelText: "Email"),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      _addUser();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
