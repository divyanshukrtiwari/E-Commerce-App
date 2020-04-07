import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

enum filterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    //final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Shop',
        ),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (ctx, cartData, child) => Badge(
              child: child,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {},
            ),
          ),
          PopupMenuButton(
            onSelected: (filterOptions selectedValue) {
              setState(
                () {
                  if (selectedValue == filterOptions.Favourites) {
                    _showOnlyFavourites = true;
                  } else {
                    _showOnlyFavourites = false;
                  }
                },
              );
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(
                    'Show Favourite',
                  ),
                  value: filterOptions.Favourites),
              PopupMenuItem(
                  child: Text(
                    'Show All',
                  ),
                  value: filterOptions.All),
            ],
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
