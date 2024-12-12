import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchhub/Pages/cart.dart';
import 'package:watchhub/Pages/user_profile.dart';
import 'package:watchhub/Pages/edit_address_page.dart';

class ProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  ProfilePage({required this.userProfile});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserProfile userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = widget.userProfile;
  }

  // Callback function to update user profile
  void _updateUserProfile(UserProfile updatedProfile) {
    setState(() {
      userProfile = updatedProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartModel = Provider.of<ShoppingCartModel>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: Text("Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display dynamically entered shipping address
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shipping Address",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      _buildAddressDetail("Name", userProfile.name),
                      _buildAddressDetail("Last Name", userProfile.lastName),
                      _buildAddressDetail("Address", userProfile.address),
                      _buildAddressDetail("City", userProfile.city),
                      _buildAddressDetail(
                          "Postal Code", userProfile.postalCode),
                      _buildAddressDetail("Country", userProfile.country),
                      SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            // Navigate to the EditAddressPage for updating the address
                            UserProfile updatedProfile = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditAddressPage(userProfile: userProfile),
                              ),
                            );

                            // If the user updated the profile, call the callback to update the state
                            if (updatedProfile != null) {
                              _updateUserProfile(updatedProfile);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Edit Address",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Orders History",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              // Display cart items
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cartModel.cartItems.length,
                itemBuilder: (context, index) {
                  var productDetails = cartModel.cartItems[index]['details'];
                  var quantity = cartModel.cartItems[index]['quantity'];
                  double totalPrice = (productDetails['price'] ?? 0) * quantity;

                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(productDetails['image'] ?? ''),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      title: Text(
                        productDetails['productName'] ?? '',
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'Price: \$${productDetails['price']?.toStringAsFixed(2) ?? 'N/A'}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Quantity: $quantity',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
