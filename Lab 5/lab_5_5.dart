import 'dart:io';

void main() {
  int sum = 0;
  print("Enter size of array : ");
  int n = int.parse(stdin.readLineSync()!);
  List<int> list = [];

  for (int i = 0; i < n; i++) {
    print("enter element at index $i : ");
    list.add(int.parse(stdin.readLineSync()!));
  }
  for (int i = 0; i < list.length; i++) {
    if (list[i] % 3 == 0 || list[i] % 5 == 0) {
      sum += list[i];
    }
  }
  print("Sum is = $sum");
}