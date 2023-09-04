
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:foodapplication/models/basketProducts.dart';

// import 'package:foodapplication/providers/user_provider.dart';
// import '../../../models/product.dart';
// import '../../../models/user.dart';
// import 'auth_service.dart';

// import 'package:foodapplication/models/product.dart';
// import 'package:foodapplication/providers/user_provider.dart';
// import 'package:provider/provider.dart';


// List<Product> get basketItems => basketProducts.keys.toList();

//   double get basketTotalMoney {
//     if (basketProducts.isEmpty) {
//       return 0;
//     } else {
//       double _total = 0;
//       basketProducts.forEach((key, value) {
//         _total += key.price * value;
//       });
//       return _total;
//     }
//   }

//   int get totalProduct {
//     return basketProducts.length;
//   }

//   void addFirstItemToBasket(Product product) {
//     basketProducts[product] = 1;
//     service.addProduct(product);
//     notifyListeners();
//   }

//   void incrementProduct(Product product) {
//     if (basketProducts[product] == null) {
//       addFirstItemToBasket(product);
//       return;
//     } else
//       basketProducts[product]++;
//     notifyListeners();
//   }

//   void increseProduct(Product product) {
//     if (basketProducts[product] == null) return;
//     if (basketProducts[product] == 0) {
//       basketProducts.removeWhere((key, value) => key == product);
//     } else {
//       basketProducts[product]--;
//     }
//     notifyListeners();


// class MyBasketPage extends StatelessWidget {
//   final String title;

//   MyBasketPage({required this.title, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(actions: [buildActionChipTotalMoney(context)]),
//       body: buildListViewBaskets(context),
//     );
//   }

//   Widget buildActionChipTotalMoney(BuildContext context) {
//     return ActionChip(
//       label: Text('Total: \$${context.watch<User>().basketTotalMoney.toStringAsFixed(2)}'),
//       onPressed: () {
//         // Add action for total money chip here if needed.
//       },
//     );
//   }

//   ListView buildListViewBaskets(BuildContext context) {
//     final basketItems = context.watch<User>().basketItems;

//     return ListView.builder(
//       itemCount: basketItems.length,
//       itemBuilder: (context, index) {
//         final product = basketItems[index];
//         final itemCount = context.watch<User>().basketProducts[product] ?? 0;

//         return ShopCard(product: product, itemCount: itemCount, context: context);
//       },
//     );
//   }
// }


// class ShopCard extends StatelessWidget {
//   final Product product;
//   final int itemCount;
//   final BuildContext context;

//   ShopCard({required this.product, required this.itemCount, required this.context});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             buildIconButtonRemove(context),
//             Text(itemCount.toString()),
//             buildIconButtonAdd(context),
//           ],
//         ),
//         title: buildSizedBoxImage(context),
//         subtitle: buildWrapSub(),
//       ),
//     );
//   }

//   IconButton buildIconButtonAdd(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.add),
//       onPressed: () {
//         context.read<User>().incrementProduct(product);
//       },
//     );
//   }

//   IconButton buildIconButtonRemove(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.remove),
//       onPressed: () {
//         context.read<User>().decreaseProduct(product);
//       },
//     );
//   }

//   SizedBox buildSizedBoxImage(BuildContext context) {
//     // Implement this method to display the product image
//     return SizedBox();
//   }

//   Widget buildWrapSub() {
//     // Implement this method to display product information
//     return SizedBox();
//   }
// }


