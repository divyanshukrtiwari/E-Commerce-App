import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/order_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('My Shop'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
              'Shop',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text(
              'Orders',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routename);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Manage Products',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).LogOut();
            },
          ),
        ],
      ),
    );
  }
}
