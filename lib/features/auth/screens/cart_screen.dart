import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodapplication/providers/product_provider.dart';


class CartPage extends StatefulWidget {
   static const String routeName = '/cart_screen';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Consumer<Cart>(
        builder: (BuildContext context, Cart cart, Widget? child) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: cart.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = cart.products[index];
                    return ListTile(
                      title: Text(item.productname ?? ''),
                      subtitle: Text('Price: \$${item.price.toString()}'),
                      trailing: Text('Remove from Cart'),
                      onTap: () {
                        cart.removeFromCart(item);
                      },
                    );
                  },
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'TOTAL: \$${cart.total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
