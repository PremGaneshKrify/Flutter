// import 'package:flutter/material.dart';

// class MyAppBar extends StatelessWidget {
//   const MyAppBar({required this.title, Key? key}) : super(key: key);

//   // Fields in a Widget subclass are always marked "final".

//   final Widget title;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56.0, // in logical pixels
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       decoration: BoxDecoration(color: Colors.blue[500]),
//       // Row is a horizontal, linear layout.
//       child: Row(
//         // <Widget> is the type of items in the list.
//         children: [
//           const IconButton(
//             icon: Icon(Icons.menu),
//             tooltip: 'Navigation menu',
//             onPressed: null, // null disables the button
//           ),
//           // Expanded expands its child
//           // to fill the available space.
//           Expanded(
//             child: title,
//           ),
//           const IconButton(
//             icon: Icon(Icons.search),
//             tooltip: 'Search',
//             onPressed: null,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyScaffold extends StatelessWidget {
//   const MyScaffold({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Material is a conceptual piece
//     // of paper on which the UI appears.
//     return Material(
//       // Column is a vertical, linear layout.
//       child: Column(
//         children: [
//           MyAppBar(
//             title: Text(
//               'Example title',
//               style: Theme.of(context) //
//                   .primaryTextTheme
//                   .headline6,
//             ),
//           ),
//           const Expanded(
//             child: Center(
//               child: Text('Hello, world!'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(
//     const MaterialApp(
//       title: 'My app', // used by the OS task switcher
//       home: SafeArea(
//         child: MyScaffold(),
//       ),
//     ),
//   );
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       title: 'Flutter Tutorial',
//       home: TutorialHome(),
//     ),
//   );
// }

// class TutorialHome extends StatelessWidget {
//   const TutorialHome({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Scaffold is a layout for
//     // the major Material Components.
//     return Scaffold(
//       appBar: AppBar(
//         leading: const IconButton(
//           icon: Icon(Icons.menu),
//           tooltip: 'Navigation menu',
//           onPressed: null,
//         ),
//         title: const Text('Example title'),
//         actions: const [
//           IconButton(
//             icon: Icon(Icons.search),
//             tooltip: 'Search',
//             onPressed: null,
//           ),
//         ],
//       ),
//       // body is the majority of the screen.
//       body: const Center(
//         child: Text('Hello, world!'),
//       ),
//       floatingActionButton: const FloatingActionButton(
//         tooltip: 'Add', // used by assistive technologies
//         child: Icon(Icons.add),
//         onPressed: null,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class MyButton extends StatelessWidget {
//   const MyButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         print('MyButton was tapped!');
//       },
//       child: Container(
//         height: 50.0,
//         padding: const EdgeInsets.all(8.0),
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           color: Colors.lightGreen[500],
//         ),
//         child: const Center(
//           child: Text('Engage'),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(
//     const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: MyButton(),
//         ),
//       ),
//     ),
//   );
// }

// import 'package:flutter/material.dart';

// class Counter extends StatefulWidget {
//   // This class is the configuration for the state.
//   // It holds the values (in this case nothing) provided
//   // by the parent and used by the build  method of the
//   // State. Fields in a Widget subclass are always marked
//   // "final".

//   const Counter({Key? key}) : super(key: key);

//   @override
//   _CounterState createState() => _CounterState();
// }

// class _CounterState extends State<Counter> {
//   int _counter = 0;

//   void _increment() {
//     print("hai   1   ");
//     setState(() {
//       // This call to setState tells the Flutter framework
//       // that something has changed in this State, which
//       // causes it to rerun the build method below so that
//       // the display can reflect the updated values. If you
//       // change _counter without calling setState(), then
//       // the build method won't be called again, and so
//       // nothing would appear to happen.
//     });
//     print("$_counter    before ");
//     _counter++;
//     print("$_counter    after ");
//     print("hai   2   ");
//     print("hai   3   ");
//     print("hai   4   ");
//     print("hai   5   ");
//     print("hai   6   ");
//     print("hai   7   ");
//     print("hai   8   ");
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called,
//     // for instance, as done by the _increment method above.
//     // The Flutter framework has been optimized to make
//     // rerunning build methods fast, so that you can just
//     // rebuild anything that needs updating rather than
//     // having to individually changes instances of widgets.
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         ElevatedButton(
//           onPressed: _increment,
//           child: const Text('Increment'),
//         ),
//         const SizedBox(width: 16),
//         Text('Count: $_counter'),
//       ],
//     );
//   }
// }

// void main() {
//   runApp(
//     const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Counter(),
//         ),
//       ),
//     ),
//   );
// }




import 'package:flutter/material.dart';

class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ShoppingListItem(
            product: const Product(name: 'Chips'),
            inCart: true,
            onCartChanged: (product, inCart) {},
          ),
        ),
      ),
    ),
  );
}