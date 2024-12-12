import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchhub/Pages/Shippingaddress.dart';

class CartPage extends StatefulWidget {
  final Map<String, dynamic> productDetails;

  const CartPage({Key? key, required this.productDetails}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cartModel = Provider.of<ShoppingCartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cartModel.cartItems.length,
        itemBuilder: (context, index) {
          var productDetails = cartModel.cartItems[index]['details'];
          var quantity = cartModel.cartItems[index]['quantity'];
          double totalPrice = (productDetails['price'] ?? 0) * quantity;

          return Card(
            color: Colors.blueGrey.shade200,
            // Change card background color to grey
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 100,
                      child: productDetails['image'] != null &&
                              productDetails['image'] is String
                          ? Image.asset(
                              productDetails['image']!,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productDetails['productName'] ?? '',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Price: \$${productDetails['price']?.toStringAsFixed(2) ?? 'N/A'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Quantity: $quantity',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          color: Colors.black, // Change button color to blue
                          onPressed: () {
                            cartModel.decreaseQuantity(index);
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.black, // Change button color to blue
                          onPressed: () {
                            cartModel.increaseQuantity(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: Colors.redAccent.shade400, size: 30),
                          onPressed: () {
                            cartModel.removeFromCart(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${cartModel.getTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShippingAddressPage()),
                );
              },
              label: Text(
                'Proceed to Checkout',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              icon: Icon(Icons.arrow_forward),
              backgroundColor: Colors
                  .blueGrey.shade200,
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppingCartModel extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> productDetails) {
    _cartItems.add({'details': productDetails, 'quantity': 1});
    notifyListeners();
  }

  int getCartItemsCount() {
    return _cartItems.length;
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _cartItems[index]['quantity']++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double total = 0;
    _cartItems.forEach((item) {
      total += (item['details']['price'] ?? 0) * (item['quantity'] ?? 0);
    });
    return total;
  }
}
