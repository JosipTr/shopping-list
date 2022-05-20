import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping List"),
        ),
        body: Center(
          child: ShoppingListItem(product: Product(name: "Hammer"), inCart: true, onCartChanged: (product, inCart) {}),
        ),
      ),
    );
  }
}




class Product {
  final String name;

  Product({required this.name});
}


typedef CartChangedCallback = Function(Product product, bool inCart);


class ShoppingListItem extends StatelessWidget {
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  ShoppingListItem(
      {Key? key,
      required this.product,
      required this.inCart,
      required this.onCartChanged})
      : super(key: ObjectKey(product));

  Color _getColor() {
    return inCart
        ? Colors.black54
        : Colors.red;
  }

  TextStyle? _getTextStyle() {
    if (!inCart) return null;
    return const TextStyle(fontStyle: FontStyle.italic, decoration: TextDecoration.lineThrough, color: Colors.green);
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(),
        child: Text(product.name[0]), 
      ),
      title: Text(product.name, style: _getTextStyle())
    );
  }
}
