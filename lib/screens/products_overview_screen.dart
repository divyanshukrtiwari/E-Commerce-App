import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../widgets/products_grid.dart';
// import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import 'package:badges/badges.dart';

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
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration.zero).then((_){
    //Provider.of<Products>(context).fetchProducts();
    //});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    //final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Shop',
        ),
        actions: <Widget>[
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
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : ProductsGrid(_showOnlyFavourites),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Consumer<Cart>(
          builder: (ctx, cartData, child) {
            return Badge(
              child: child,
              badgeColor: Colors.white,
              position: BadgePosition.topEnd(top: -15, end: -8),
              badgeContent: Text(
                cartData.itemCount.toString(),
                style: TextStyle(color: Colors.pink),
              ),
            );
          },
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(
            CartScreen.routeName,
          );
        },
      ),
    );
  }
}
