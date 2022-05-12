import 'dart:io';

void main() {
  print("Enter your name?");
  // Reading name of the Geek
  String? name = stdin.readLineSync();
  print("enter your age");
  String? age = stdin.readLineSync();
  // Printing the name
  print("Hello, $name! \n your age $age");
}
