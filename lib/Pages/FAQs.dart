import 'package:flutter/material.dart';

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

class FaqsPage extends StatefulWidget {
  @override
  _FaqsPageState createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  final List<FaqItem> faqs = [
    FaqItem(
      question: "How do I create an account on WatchHub?",
      answer:
          "To create an account, click on the Sign Up button on the app's homepage. Follow the prompts to provide necessary information and create your account.",
    ),
    FaqItem(
      question: "How can I log in and log out of my account?",
      answer:
          "Click on the Log In button, enter your credentials, and press Log In. To log out, go to your profile and choose the Log Out option.",
    ),
    FaqItem(
      question: "What if I forget my password?",
      answer:
          "If you forget your password, click on Forgot Password during login. Follow the instructions sent to your registered email to recover your account.",
    ),
    FaqItem(
      question: "How can I browse watches on WatchHub?",
      answer:
          "Navigate to the Browse Watches section to explore watches categorized by brands, types, and price ranges. Utilize filters and the search feature for a more personalized experience.",
    ),
    FaqItem(
      question: "How can I view detailed information about a specific watch?",
      answer:
          "Click on the watch you're interested in to access its detailed page. This includes images, descriptions, specifications, and prices.",
    ),
    FaqItem(
      question: "Can I modify the contents of my shopping cart?",
      answer:
          "Yes, you can add, remove, or change quantities of watches in your cart. The total price is dynamically updated as you make changes",
    ),
    FaqItem(
      question: "How do I create and edit my user profile?",
      answer:
          "you can update personal information and shipping addresses. Access order history and tracking information from your profile.",
    ),
    FaqItem(
      question: "What is the Wishlist feature and how does it work?",
      answer:
          "The Wishlist allows you to save watches for future reference. You can move items from the Wishlist to the cart when you're ready to purchase.",
    ),
    FaqItem(
      question: "How do I contact customer support?",
      answer:
          "Reach out to customer support through the use of contact form. For common queries, check the FAQ section for quick assistance.",
    ),
    FaqItem(
      question: "How does the search functionality work?",
      answer:
          "Use the search bar for a robust search experience. Results can be further narrowed down using filters such as brand, price, and product type.",
    ),
    FaqItem(
      question: "Is there an Admin Panel for managing the app?",
      answer:
          "Yes, there is an admin panel for backend management of product listings, user data, reviews, and orders.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ExpansionTile(
                title: Text(
                  faqs[index].question,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      faqs[index].answer,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18, // Adjust the font size as needed
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
