import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchhub/Pages/ProductDetailsPage.dart';
import 'package:watchhub/Pages/ProductPage.dart';
import 'package:watchhub/Pages/UIHelpers/Drawer.dart';
import 'package:watchhub/Pages/cart.dart';
import 'package:watchhub/Pages/user_profile.dart';

class Category extends StatefulWidget {
  final String tag;
  final UserProfile userProfile;

  const Category({Key? key, required this.tag, required this.userProfile})
      : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

UserProfile userProfile = UserProfile(
  name: '',
  lastName: '',
  country: '',
  city: '',
  postalCode: '',
  address: '',
);

class _CategoryState extends State<Category> {
  TextEditingController _searchController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _filteredProducts = [];
  List<Map<String, dynamic>> _products = [];
  String _selectedBrand = 'All';
  String _selectedSortingOption = 'Price Low to High';

  @override
  void initState() {
    super.initState();
    // Initialize products list
    _products = categoryProducts[widget.tag]!;
    _filteredProducts = _products;
  }

  Map<String, List<String>> categoryImages = {
    'Omega': [
      'assets/images/Omega/O1.jpg',
      'assets/images/Omega/O2.jpg',
      'assets/images/Omega/O3.jpg',
      'assets/images/Omega/O4.jpg',
      'assets/images/Omega/O5.jpg',
      'assets/images/Omega/O6.jpg'
    ],
    'Breiting': [
      'assets/images/breiting/B1.jpg',
      'assets/images/breiting/B2.webp',
      'assets/images/breiting/B3.jpg',
      'assets/images/breiting/B4.jpg',
      'assets/images/breiting/B5.jpg',
      'assets/images/breiting/B6.jpg'
    ],
    'Parenai': [
      'assets/images/Perenai/P1.jpg',
      'assets/images/Perenai/P2.webp',
      'assets/images/Perenai/P3.webp',
      'assets/images/Perenai/P4.webp',
      'assets/images/Perenai/P5.jpg',
      'assets/images/Perenai/P6.webp',
    ],
    'Tudor': [
      'assets/images/Tudor/T1.jpg',
      'assets/images/Tudor/T2.jpg',
      'assets/images/Tudor/T3.jpg',
      'assets/images/Tudor/T4.jpg',
      'assets/images/Tudor/T5.jpg',
      'assets/images/Tudor/T6.jpg',
    ],
    'Tag Heuer': [
      'assets/images/Tag/H1.jpg',
      'assets/images/Tag/H2.jpg',
      'assets/images/Tag/H3.jpg',
      'assets/images/Tag/H4.jpg',
      'assets/images/Tag/H5.jpg',
      'assets/images/Tag/H6.jpg',
    ]
  };
  Map<String, List<Map<String, dynamic>>> categoryProducts = {
    'Omega': [
      {
        'productName': 'CONSTELLATION',
        'description':
            'The dramatic and enduring design of the OMEGA Constellation is characterised by its famous half-moons, “claws” on the case and mono-rang bracelet.',
        'price': 299.99,
        'availability': true,
        'image': 'assets/images/Omega/O1.jpg',
      },
      {
        'productName': 'SEAMASTER',
        'description':
            'The Seamaster Aqua Terra is a superb tribute to OMEGA’s rich maritime heritage. In this 41mm model, the symmetrical case has been crafted from stainless steel, with a wave-edged design featured on the back.',
        'price': 399.99,
        'availability': true,
        'image': 'assets/images/Omega/O2.jpg',
      },
      {
        'productName': 'SPEEDMASTER',
        'description':
            'As a part of all six moon landings in history, the legendary OMEGA Speedmaster is a true icon of space as well as OMEGA’s pioneering spirit.',
        'price': 449.99,
        'availability': false,
        'image': 'assets/images/Omega/O3.jpg',
      },
      {
        'productName': 'Ocean 36th America',
        'description':
            'Debuted in 1948 as a self-winding, waterproof "civilian" version of the  wartime CK2129, the Seamaster has served Omega – and history – well. The chosen timepiece of Commander Bond has also seen service in a myriad of ocean-going settings, including, since 1995, the America cup',
        'price': 349.99,
        'availability': true,
        'image': 'assets/images/Omega/O4.jpg',
      },
      {
        'productName': 'De Ville Prestige',
        'description':
            'Originally launched in 1994, the new De Ville Prestige collection features 39.5mm cases in either stainless steel, stainless steel and 18k yellow gold, or stainless steel and 18k red gold – nicely resolving that day-to-night dilemma',
        'price': 299.99,
        'availability': false,
        'image': 'assets/images/Omega/O5.jpg',
      },
      {
        'productName': 'No Time To Die Seamaster',
        'description':
            'James Bond might have missed his grand entrance earlier this year, when the highly anticipated final outing of Daniel Craig peerless spy was postponed until November, but fortunately the watch the actor collaborated on with Omega hit its spot in style',
        'price': 599.99,
        'availability': true,
        'image': 'assets/images/Omega/O6.jpg',
      },
    ],
    'Breiting': [
      {
        'productName': 'TOP TIME B01 DEUS',
        'description':
            'The 1960s was a decade of experimentation, fun, freedom and energy. Whether cruising on a motorcycle or revving up a sportscar, living life at full speed was the order of the day. Willy Breitling felt this change of pace and set out to design an unconventional',
        'price': 299.99,
        'availability': true,
        'image': 'assets/images/breiting/B1.jpg',
      },
      {
        'productName': 'AVENGER B01 CHRONOGRAPH',
        'description':
            'Built for jet pilots, the Avenger is designed to take on the toughest cockpits and keep coming back for more. But you don’t need air force credentials to appreciate its bold design, exceptional resilience, and next-level functionality.',
        'price': 299.99,
        'availability': true,
        'image': 'assets/images/breiting/B2.webp',
      },
      {
        'productName': 'NAVITIMER AUTOMATIC 36',
        'description':
            'Breitling’s icon—for the journey. The Navitimer is one of the most recognizable watches ever made. It’s on collectors’ lists of the greatest watches of all time.',
        'price': 449.99,
        'availability': true,
        'image': 'assets/images/breiting/B3.jpg',
      },
      {
        'productName': 'PREMIER B01 CHRONOGRAPH',
        'description':
            ' The Premier B01 Chronograph 42 is available in an array of dial colors and case materials. It comes on a choice of classic alligator leather strap or sleek 7-row metal bracelet.',
        'price': 349.99,
        'availability': true,
        'image': 'assets/images/breiting/B4.jpg',
      },
      {
        'productName': 'SUPEROCEAN AUTOMATIC 46',
        'description':
            'Built for jet pilots, the Avenger is designed to take on the toughest cockpits and keep coming back for more. But you don’t need air force credentials to appreciate its bold design, exceptional resilience, and next-level functionality.',
        'price': 299.99,
        'availability': false,
        'image': 'assets/images/breiting/B5.jpg',
      },
      {
        'productName': 'CHRONOMAT AUTOMATIC 36',
        'description':
            'James Bond might have missed his grand entrance earlier this year, when the highly anticipated final outing of Daniel Craig peerless spy was postponed until November, but fortunately the watch the actor collaborated on with Omega hit its spot in style',
        'price': 599.99,
        'availability': true,
        'image': 'assets/images/breiting/B6.jpg',
      },
    ],
    'Parenai': [
      {
        "productName": "Panerai Luminor",
        "description":
            "The Panerai Luminor collection is iconic, featuring large cushion-shaped cases with a crown-protecting bridge. These watches are known for their bold design, legible dials, and robust mechanical movements.",
        "price": 199.99,
        "availability": false,
        "image": 'assets/images/Perenai/P1.jpg'
      },
      {
        "productName": "Panerai Radiomir",
        "description":
            "The Panerai Radiomir series pays homage to the brand's military heritage with vintage-inspired designs. These watches typically feature clean, simple dials, wire lugs, and a more classic aesthetic.",
        "price": 349.99,
        "availability": true,
        "image": 'assets/images/Perenai/P2.webp'
      },
      {
        "productName": "Panerai Submersible",
        "description":
            "The Panerai Submersible collection is designed for underwater exploration and adventure. These dive watches feature high water resistance, rotating bezels, and luminous dials for excellent legibility underwater.",
        "price": 99.29,
        "availability": false,
        "image": 'assets/images/Perenai/P3.webp'
      },
      {
        "productName": "Panerai Luminor Due",
        "description":
            "The Panerai Luminor Due collection offers a more refined and slimmer profile compared to traditional Panerai watches. These timepieces are designed for everyday wear, with elegant case proportions and versatile styling.",
        "price": 499.99,
        "availability": true,
        "image": 'assets/images/Perenai/P4.webp',
      },
      {
        "productName": "Panerai Luminor Marina",
        "description":
            "The Panerai Luminor Marina is an iconic timepiece renowned for its bold and distinctive design. Featuring the characteristic cushion-shaped case and crown-protecting bridge, this watch exudes rugged elegance. With luminescent indices and hands, it ensures excellent legibility in all lighting conditions.",
        "price": 299.99,
        "availability": true,
        "image": 'assets/images/Perenai/P5.jpg'
      },
      {
        "productName": "Panerai Luminor GMT",
        "description":
            "The Panerai Luminor GMT is a versatile traveler's watch equipped with a GMT complication, allowing the wearer to track time in two different time zones simultaneously. With its robust construction, legible dial, and signature crown-protecting bridge, this watch combines functionality with Panerai's distinctive design language.",
        "price": 599.99,
        "availability": true,
        "image": 'assets/images/Perenai/P6.webp',
      }
    ],
    'Tudor': [
      {
        "productName": "Tudor Black Bay Fifty-Eight",
        "description":
            "The Tudor Black Bay Fifty-Eight is a tribute to the iconic Tudor diver's watches of the 1950s. With its vintage-inspired design, 39mm case, and slim profile, it captures the essence of classic diving timepieces while incorporating modern technology and craftsmanship.",
        "price": 349.99,
        "availability": true,
        "image": "assets/images/Tudor/T1.jpg"
      },
      {
        "productName": "Tudor Pelagos",
        "description":
            "The Tudor Pelagos is a professional diver's watch designed to meet the demands of deep-sea exploration. Constructed from lightweight titanium and featuring a helium escape valve, it offers exceptional performance and reliability in the most challenging underwater environments.",
        "price": 449.99,
        "availability": true,
        "image": "assets/images/Tudor/T2.jpg"
      },
      {
        "productName": "Tudor Black Bay Chrono",
        "description":
            "The Tudor Black Bay Chrono combines the elegance of Tudor's heritage diver's watches with the functionality of a chronograph complication. With its robust construction, retro-inspired design, and reliable movement, it's a versatile timepiece for both land and sea.",
        "price": 599.99,
        "availability": true,
        "image": "assets/images/Tudor/T3.jpg"
      },
      {
        "productName": "Tudor Heritage Ranger",
        "description":
            "The Tudor Heritage Ranger pays homage to the brand's rich history of producing rugged and reliable field watches. With its vintage-inspired design, durable construction, and versatile styling, it's the perfect companion for outdoor adventures and everyday wear.",
        "price": 299.99,
        "availability": true,
        "image": "assets/images/Tudor/T4.jpg"
      },
      {
        "productName": "Tudor Black Bay GMT",
        "description":
            "The Tudor Black Bay GMT is a traveler's watch equipped with a GMT complication, allowing the wearer to track time in two different time zones simultaneously. With its bold design, robust construction, and reliable movement, it's an essential companion for frequent flyers and globetrotters.",
        "price": 499.99,
        "availability": true,
        "image": "assets/images/Tudor/T5.jpg"
      },
      {
        "productName": "Tudor Royal",
        "description":
            "The Tudor Royal collection offers a blend of elegance and versatility, with a range of sizes, materials, and dial options to suit any style or occasion. Whether worn as a dress watch or a daily timepiece, the Tudor Royal exudes sophistication and refinement.",
        "price": 399.99,
        "availability": true,
        "image": "assets/images/Tudor/T6.jpg"
      }
    ],
    'Tag Heuer': [
      {
        "productName": "Tag Heuer Carrera",
        "description":
            "The Tag Heuer Carrera is a classic racing-inspired watch known for its sporty yet sophisticated design. With its chronograph functionality and sleek aesthetics, it's a favorite among motorsport enthusiasts and watch aficionados alike.",
        "price": 199.99,
        "availability": true,
        "image": "assets/images/Tag/H1.jpg"
      },
      {
        "productName": "Tag Heuer Monaco",
        "description":
            "The Tag Heuer Monaco is an iconic square-shaped watch famously associated with the world of motorsports, particularly with Steve McQueen in the film 'Le Mans'. Its distinctive design and racing pedigree make it a timeless classic.",
        "price": 599.99,
        "availability": false,
        "image": "assets/images/Tag/H2.jpg"
      },
      {
        "productName": "Tag Heuer Aquaracer",
        "description":
            "The Tag Heuer Aquaracer is a professional dive watch designed for underwater exploration. With its high water resistance, unidirectional rotating bezel, and luminescent markers, it's a reliable companion for divers and water sports enthusiasts.",
        "price": 599.99,
        "availability": true,
        "image": "assets/images/Tag/H3.jpg"
      },
      {
        "productName": "Tag Heuer Formula 1",
        "description":
            "The Tag Heuer Formula 1 collection is inspired by the adrenaline and precision of Formula 1 racing. With its sporty design, chronograph functionality, and durable construction, it's the perfect watch for those with a passion for motorsports.",
        "price": 299.99,
        "availability": true,
        "image": "assets/images/Tag/H4.jpg"
      },
      {
        "productName": "Tag Heuer Autavia",
        "description":
            "The Tag Heuer Autavia is a versatile and rugged chronograph watch originally designed for automotive and aviation enthusiasts. With its distinctive rotating bezel and vintage-inspired design, it's a stylish choice for adventurers and collectors alike.",
        "price": 699.99,
        "availability": true,
        "image": "assets/images/Tag/H5.jpg"
      },
      {
        "productName": "Tag Heuer Carrera Sport Chronograph",
        "description":
            "The Tag Heuer Carrera Sport Chronograph combines classic elegance with modern sports performance. With its sleek design, chronograph functionality, and robust construction, it's the perfect companion for both everyday wear and sporting activities.",
        "price": 799.99,
        "availability": true,
        "image": "assets/images/Tag/H6.jpg"
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context, userProfile),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Category.webp'),
                    fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.4)
                ]),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.menu, color: Colors.white),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CartPage(productDetails: {})),
                                );
                              },
                              icon: Stack(
                                children: [
                                  Icon(Icons.shopping_cart,
                                      color: Colors.white),
                                  if (Provider.of<ShoppingCartModel>(context)
                                          .getCartItemsCount() >
                                      0)
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 15,
                                          minHeight: 5,
                                        ),
                                        child: Text(
                                          Provider.of<ShoppingCartModel>(
                                                  context)
                                              .getCartItemsCount()
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          hintText: 'Search for products...',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black,
                          )),
                        ),
                        onChanged: (value) {
                          setState(() {
                            List<Map<String, dynamic>> filteredProducts = [];
                            categoryProducts.forEach((category, products) {
                              products.forEach((product) {
                                final productTitle =
                                    product['productName'].toLowerCase();
                                final searchQuery = value.toLowerCase();
                                if (productTitle.contains(searchQuery)) {
                                  filteredProducts.add(product);
                                }
                              });
                            });
                            setState(() {
                              _filteredProducts = filteredProducts;
                            });
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<String>(
                            value: _selectedBrand,
                            items: [
                              'All',
                              'Omega',
                              'Breiting',
                              'Parenai',
                              'Tudor',
                              'Tag Heuer'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedBrand = newValue!;
                                _filterProductsByBrand(
                                    _selectedBrand); // Update filtered products
                              });
                            },
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            dropdownColor: Colors.black,
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.white),
                          ),
                          DropdownButton<String>(
                            value: _selectedSortingOption,
                            items: ['Price Low to High', 'Price High to Low']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedSortingOption = newValue!;
                                if (_selectedSortingOption ==
                                    'Price Low to High') {
                                  _sortProductsByPrice(true);
                                } else {
                                  _sortProductsByPrice(false);
                                }
                              });
                            },
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            dropdownColor: Colors.black,
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("Our New Products",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("View more",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17)),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Brands",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "All",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Category(
                          Image: 'assets/images/c1.jpg',
                          Title: 'Omega',
                          tag: 'Omega'),
                      Category(
                          Image: 'assets/images/c2.jpg',
                          Title: 'Breiting',
                          tag: 'Breiting'),
                      Category(
                          Image: 'assets/images/c3.jpg',
                          Title: 'Parenai ',
                          tag: 'Parenai'),
                      Category(
                          Image: 'assets/images/c4.jpg',
                          Title: 'Tudor',
                          tag: 'Tudor'),
                      Category(
                          Image: 'assets/images/c5.webp',
                          Title: 'Tag Heuer',
                          tag: 'Tag Heuer'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Most Sale Watches",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "All",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Sellproduct(
                        Image: 'assets/images/Omega/O5.jpg',
                        Title: 'Omega',
                      ),
                      Sellproduct(
                          Image: 'assets/images/breiting/B4.jpg',
                          Title: 'Breiting'),
                      Sellproduct(
                          Image: 'assets/images/Perenai/P5.jpg',
                          Title: 'Parenai'),
                      Sellproduct(
                          Image: 'assets/images/Tudor/T2.jpg', Title: 'Tudor'),
                      Sellproduct(
                          Image: 'assets/images/Tag/H5.jpg',
                          Title: 'tag heuer'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Search Results",
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final product = _filteredProducts[index];
              final imagePath =
                  product['image']; // Retrieve image path from product data
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        product: product,
                        imagePath: imagePath,
                      ),
                    ),
                  );
                },
                child: AspectRatio(
                  aspectRatio: 2.1 / 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        // Use the retrieved image path
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.8),
                            Colors.black.withOpacity(.0),
                          ],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            product['productName'],
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
              );
            },
          ),
        ]),
      ),
    );
  }

// Function to sort products based on price
  void _sortProductsByPrice(bool ascending) {
    setState(() {
      _filteredProducts.sort((a, b) {
        if (ascending) {
          return a['price'].compareTo(b['price']);
        } else {
          return b['price'].compareTo(a['price']);
        }
      });
    });
  }

  // Function to filter products by brand
  void _filterProductsByBrand(String brand) {
    setState(() {
      if (brand == 'All') {
        _filteredProducts = _products;
      } else {
        _filteredProducts = categoryProducts[brand] ?? [];
      }
    });
  }

  Widget Category({Image, Title, tag}) {
    return AspectRatio(
      aspectRatio: 2 / 1.8,
      child: Hero(
        tag: tag,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Productshop(Image: Image, Title: Title, tag: tag),
                ));
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(Image), fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.0)
                ]),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    Title,
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
      ),
    );
  }

  Widget Sellproduct({Image, Title}) {
    return AspectRatio(
      aspectRatio: 2.1 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:
                DecorationImage(image: AssetImage(Image), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.black.withOpacity(.8),
              Colors.black.withOpacity(.0)
            ]),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                Title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
