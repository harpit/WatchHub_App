import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteProducts;
  final List<String> favoriteProductImages;

  const FavouritePage(
      {Key? key,
      required this.favoriteProducts,
      required this.favoriteProductImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: favoriteProductImages.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: Image.asset(
              favoriteProductImages[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
