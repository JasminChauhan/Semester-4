import 'dart:io';

void main() {
  List<int>? list = [];
  for (int i = 0; i < 5; i++) {
      list.add(int.parse(stdin.readLineSync()!));
  }
  list.sort();
  print(list);

}