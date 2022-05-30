// // importing dart:io file
// import 'dart:io';

// void main() {
//   int prem = 1000000;
//   int praveen = 2;
//   int veera = 500000;
//   int? bal;

//   print("Enter your name?");
//   // Reading name of the Geek
//   String? name = stdin.readLineSync();
//   if (name == "prem") {
//     print("enter type withdraw or deposit");
//     String? type = stdin.readLineSync();
//     print("enter amount");
//     int? amount = int.parse(stdin.readLineSync().toString());

//     if (type == "withdraw") {
//       bal = prem - amount;
//     } else {
//       bal = prem + amount;
//     }
//     print(bal);
//   }
// }

void main() {
  double n1 = 2.123;

  var value = n1.truncate();

  print("The truncated value of 2.123 = ");
}
