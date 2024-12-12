import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchhub/Pages/cart.dart';

class ProductDetail extends StatelessWidget {
  final Map<String, dynamic> product;

  final String? productName;
  final String? description;
  final double? price;
  final bool? availability;
  final String? image;
  final VoidCallback? onBuyNowPressed;

  ProductDetail(
      {required this.productName,
      required this.description,
      required this.price,
      required this.availability,
      required this.image,
      required this.product,
      this.onBuyNowPressed});

  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'John Doe',
      'rating': 4,
      'comment': 'Great product, highly recommended!'
    },
    {'name': 'Jane Smith', 'rating': 5, 'comment': 'Absolutely love it!'},
  ];

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
                        image: AssetImage(image ?? ''),
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
                              productName ?? 'Product Name',
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
                                  'Price: \$${price?.toStringAsFixed(2) ?? 'N/A'}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'Availability: ${availability ?? false ? "In Stock" : "Out of Stock"}',
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
                          'Description: ${description ?? 'No description available'}',
                          style: TextStyle(
                              color: Colors.grey, height: 1.7, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  // New reviews and ratings section
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reviews:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person, color: Colors.white),
                                    SizedBox(width: 5),
                                    Text(
                                      review['name'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: List.generate(
                                        review['rating'],
                                        (index) => Icon(Icons.star,
                                            color: Colors.yellow),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  review['comment'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Positioned.fill(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  if (availability ?? false) {
                    // Product is in stock, add to cart
                    Provider.of<ShoppingCartModel>(context, listen: false)
                        .addToCart({
                      'productName': productName,
                      'price': price,
                      'image': image,
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(
                          productDetails: {
                            'productName': productName,
                            'price': price,
                            'image': image,
                            // Add other relevant details
                          },
                        ),
                      ),
                    );
                  } else {
                    // Product is out of stock, show alert dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Out of Stock"),
                          content: Text(
                              "Sorry, this product is currently out of stock."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
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
                        fontSize: 20,
                      ),
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
