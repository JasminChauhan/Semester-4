import 'dart:io';

void createMap(Map<String, Object> map, String name, int number, int age) {
  map[name] = {"Number": number, "Age": age};
}

void readEntries(Map<String, Object> map, String name) {
  if (map.isEmpty)
    print("No entries found");
  else {
    print("$name : ${map[name]}");
  }
}

void readAll(Map<String, Object> map) {
  if (map.isEmpty)
    print("No entries found");
  else {
    print("$map");
  }
}

void main() {
  Map<String, Object> map = {};
  while (true) {
    print("enter 1 for make map : ");
    print("enter 2 for read map By name : ");
    print("enter 3 for read All  : ");
    print("enter 4 to exit : ");
    int a = int.parse(stdin.readLineSync()!);

    switch (a) {
      case 1:
        print("enter name : ");
        String name = stdin.readLineSync()!;
        print("enter Number : ");
        int number = int.parse(stdin.readLineSync()!);
        print("enter Age : ");
        int age = int.parse(stdin.readLineSync()!);
        createMap(map, name, number, age);
        break;
      case 2:
        print("enter name you want to find : ");
        String name = stdin.readLineSync()!;
        readEntries(map, name);
        break;
      case 3:
        readAll(map);
        break;
      case 4:
        print("Exiting......");
        return;
      default:
        print("Invalid Input");
    }
  }
}
