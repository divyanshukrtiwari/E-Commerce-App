import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final num price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id, 
    @required this.title, 
    @required this.description, 
    @required this.price, 
    @required this.imageUrl, 
    this.isFavourite = false,
  });

  void toggleFavouriteStatus(){
    isFavourite =! isFavourite;
    notifyListeners();
  }
}