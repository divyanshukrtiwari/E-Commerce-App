import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDeatilScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  ProductDeatilScreen();

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).fingById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 5,
                ),
                Card(
                  margin: EdgeInsets.all(5),
                  elevation: 2,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            loadedProduct.title,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '\u20B9 ${loadedProduct.price}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      width: double.infinity,
                      child: Text(
                        loadedProduct.description,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
