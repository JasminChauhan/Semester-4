void main() {
  List<String> list = ["Delhi", "Mumbai", "Bangalore", "Hyderabad","Ahmedabad"];
  print("before replacing Ahmedabad :  $list");

  for (int i = 0; i < list.length; i++) {
    if(list[i].contains("Ahmedabad"))
      list[i] = "Surat";
  }
  print("After replacing Ahmedabad :  $list");
}