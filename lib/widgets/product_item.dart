import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Consumer<Product>(
      builder: (context, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDeatilScreen.routeName,
                arguments: product.id,
              );
            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/download.jpeg'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          footer: GridTileBar(
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavouriteStatus(authData.token, authData.userId);
              },
              color: Colors.pinkAccent,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.pinkAccent,
              ),
              onPressed: () {
                cart.addItem(
                    product.id, product.price, product.title, product.imageUrl);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added Product to Cart',
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.yellow,
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              },
              color: Colors.pinkAccent,
            ),
          ),
        ),
      ),
    );
  }
}
