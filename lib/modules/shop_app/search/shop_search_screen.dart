import 'package:flutter/material.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        'Search Screen' ,style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
