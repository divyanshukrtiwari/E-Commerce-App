import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.price,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://my-shop-e4082.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'price': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartProducts.map((cp) => {
          'id': cp.id,
          'title':cp.title,
          'quantity':cp.quantity,
          'price': cp.price,
          'imageurl':cp.imageUrl,
        }).toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        price: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
