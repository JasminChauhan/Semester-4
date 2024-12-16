import 'dart:io';

class User {
 List<Map<dynamic , dynamic>> userList = [];

 void addUserInList(String name ,int age ,String email) {
   Map<dynamic , dynamic> map = {};
   map["name"] = name;
   map["age"] = age;
   map["email"] = email;
   userList.add(map);
 }

 List<Map<dynamic , dynamic>> readUserList() {
   return userList;
 }

 void updateUser(String name , int age , String email, int index) {
   Map<dynamic , dynamic> map = {};
   map["name"] = name;
   map["age"] = age;
   map["email"] = email;
   userList[index] = map;
 }

 void deleteUser(int index) {
   userList.removeAt(index);
 }
}
void main() {
  User user = User();
  while (true) {
    print(
        "Enter choice for \n 1. For Insert \n 2. For Read \n 3. For Update \n 4. For Delete \n 5. For Exit");
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1 :
        stdout.write("Enter Name : ");
        String name = stdin.readLineSync()!;
        stdout.write("Enter Age : ");
        int age = int.parse(stdin.readLineSync()!);
        stdout.write("Enter Email : ");
        String email = stdin.readLineSync()!;
        user.addUserInList(name, age, email);
        break;
      case 2 :
        print(user.readUserList());
        break;
      case 3 :
        stdout.write("Enter Name : ");
        String name = stdin.readLineSync()!;
        stdout.write("Enter Age : ");
        int age = int.parse(stdin.readLineSync()!);
        stdout.write("Enter Email : ");
        String email = stdin.readLineSync()!;
        stdout.write("Enter the index you want to change : ");
        int index = int.parse(stdin.readLineSync()!);
        user.updateUser(name, age, email, index);
        break;
      case 4 :
        stdout.write("Enter the index you want to delete : ");
        int index = int.parse(stdin.readLineSync()!);
        user.deleteUser(index);
        break;
      case 5 :
        print("Exiting....");
        break;
      default:
        print("Invalid input....");
    }
    if (choice == 5)
      break;
  }
}