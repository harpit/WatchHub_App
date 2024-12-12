import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchhub/Pages/cart.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final String imagePath;

  const ProductDetailsPage(
      {Key? key, required this.product, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        // Use the received image path
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            Colors.black.withOpacity(.3),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              product['productName'] ?? 'Product Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Price: \$${product['price']?.toStringAsFixed(2) ?? 'N/A'}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'Availability: ${product['availability'] ?? false ? "In Stock" : "Out of Stock"}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description: ${product['description'] ?? 'No description available'}',
                          style: TextStyle(
                              color: Colors.grey, height: 1.7, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Positioned.fill(
            bottom: 50,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Provider.of<ShoppingCartModel>(context, listen: false)
                      .addToCart({
                    'productName': product['productName'],
                    'price': product['price'],
                    'image': imagePath,
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartPage(
                              productDetails: {
                                'productName': product['productName'],
                                'price': product['price'],
                                'image': imagePath,
                                // Add other relevant details
                              },
                            )),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blueGrey[700],
                  ),
                  child: Align(
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
