import 'dart:io';
void main() {
  print("Enter size of list : ");
  int n = int.parse(stdin.readLineSync()!);
  List<int>? list1 = [];
  List<int>? list2 = [];

  for (int i = 0; i < n; i++) {
    print("Enter element in list 1 at index $i : ");
    list1.add(int.parse(stdin.readLineSync()!));
    print("Enter element in list 2 at index $i : ");
    list2.add(int.parse(stdin.readLineSync()!));
  }

  for (int i = 0; i < list1.length; i++) {
    if (list1[i] == list2[i]) {
      print("Common between Two List ${list1[i]}");
      break;
    }
  }

}