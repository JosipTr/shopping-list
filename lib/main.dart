import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingList(
        products: [
          Product(name: "Cheese"),
          Product(name: "Bread"),
          Product(name: "Garlic"),
          Product(name: "Onion")
        ],
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
    return inCart ? Colors.green : Colors.red;
  }

  Icon _getIcon() {
    return inCart
        ? const Icon(Icons.check)
        : const Icon(Icons.radio_button_unchecked);
  }

  TextStyle? _getTextStyle() {
    if (!inCart) {
      return const TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
    }
    return const TextStyle(
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.lineThrough,
        color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          onCartChanged(product, inCart);
        },
        leading: CircleAvatar(
          backgroundColor: _getColor(),
          child: _getIcon(),
        ),
        title: Text(product.name, style: _getTextStyle()));
  }
}

class ShoppingList extends StatefulWidget {
  final List<Product> products;
  const ShoppingList({Key? key, required this.products}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _shoppingCart.remove(product);
      } else {
        _shoppingCart.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
      ),
      body: ListView(
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
