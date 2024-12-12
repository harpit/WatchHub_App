import 'package:flutter/material.dart';
import 'package:watchhub/Pages/user_profile.dart';

class EditAddressPage extends StatefulWidget {
  final UserProfile userProfile;

  EditAddressPage({required this.userProfile});

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController addressController;
  late TextEditingController postalController;
  late TextEditingController countryController;
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userProfile.name);
    lastNameController =
        TextEditingController(text: widget.userProfile.lastName);
    addressController = TextEditingController(text: widget.userProfile.address);
    postalController =
        TextEditingController(text: widget.userProfile.postalCode);
    countryController = TextEditingController(text: widget.userProfile.country);
    cityController = TextEditingController(text: widget.userProfile.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Address"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: "Last Name",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Address",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: postalController,
                decoration: InputDecoration(
                  labelText: "Postal Code",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: "City",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(
                  labelText: "Country",
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.userProfile.name = nameController.text;
                    widget.userProfile.lastName = lastNameController.text;
                    widget.userProfile.address = addressController.text;
                    widget.userProfile.postalCode = postalController.text;
                    widget.userProfile.city = cityController.text;
                    widget.userProfile.country = countryController.text;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Address updated successfully')),
                    );

                    Navigator.pop(context, widget.userProfile);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey, // Set background color to blue
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
