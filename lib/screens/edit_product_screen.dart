import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _decriptionFocusNode = FocusNode();
  final _imageurlController = TextEditingController();
  final _imageurlFocusNode = FocusNode();
  var _editProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _imageurlController.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageurlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _decriptionFocusNode.dispose();
    _imageurlController.dispose();
    _imageurlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageurlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Enter a vaild Title';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (val) {
                  _editProduct = Product(
                    title: val,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                    id: null,
                    description: _editProduct.description,
                  );
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Enter a valid Price';
                  }
                  if (double.tryParse(val) == null) {
                    return 'Enter a valid Price';
                  }
                  if (double.parse(val) <= 0) {
                    return 'Enter a valid Price';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_decriptionFocusNode);
                },
                onSaved: (val) {
                  _editProduct = Product(
                    title: _editProduct.title,
                    price: double.parse(val),
                    imageUrl: _editProduct.imageUrl,
                    id: null,
                    description: _editProduct.description,
                  );
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Enter a valid description';
                  }
                  if (val.length < 10) {
                    return 'Enter a valid description';
                  }
                  return null;
                },
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _decriptionFocusNode,
                onSaved: (val) {
                  _editProduct = Product(
                    title: _editProduct.title,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                    id: null,
                    description: val,
                  );
                },
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 12,
                      right: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageurlController.text.isEmpty
                        ? Text(
                            'Enter image Url',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageurlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image Url',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter a valid Url';
                        }
                        if (!val.startsWith('http') &&
                            !val.startsWith('https')) {
                          return 'Enter a valid Url';
                        }
                        if (!val.endsWith('jpg') &&
                            !val.startsWith('jpeg') &&
                            !val.endsWith('png')) {
                          return 'Enter a valid Url';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageurlController,
                      focusNode: _imageurlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (val) {
                        _editProduct = Product(
                          title: _editProduct.title,
                          price: _editProduct.price,
                          imageUrl: val,
                          id: null,
                          description: _editProduct.description,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
