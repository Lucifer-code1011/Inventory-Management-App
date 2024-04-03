import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_flutter/mainscreen.dart';
import 'package:learn_flutter/widgets/button.dart';
import 'package:learn_flutter/widgets/import.dart';
import 'package:learn_flutter/widgets/textfield.dart';
import 'package:page_transition/page_transition.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  late DatabaseReference dbRef;
  late String imageUrl;
  File? selectedImage; // Variable to hold the selected image

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('products');
  }

  Future<void> uploadImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDireImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDireImages.child(fileName);

    try {
      // Convert PickedFile to File
      File pickedFile = File(file.path);

      // Put the file to Firebase Storage
      await referenceImageToUpload.putFile(pickedFile);

      // Get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();

      // Update the selected image
      setState(() {
        selectedImage = pickedFile;
      });
    } catch (error) {
      // Handle the error
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _submitProduct() async {
    setState(() {
      isLoading = true;
    });

    // Ensure all required fields are filled
    if (_nameController.text.isEmpty ||
        _descController.text.isEmpty ||
        _priceController.text.isEmpty) {
      _showSnackbar('Please fill all fields and select an image');
      setState(() {
        isLoading = false;
      });
      return;
    }

    String productName = _nameController.text.trim();
    String productPrice = _priceController.text.trim();
    String productDesc = _descController.text.trim();

    Map<String, dynamic> product = {
      "name": productName,
      "price": productPrice,
      "desc": productDesc,
      "image": imageUrl,
      "count": 0,
    };

    try {
      // Set the product data directly with the product name as the key
      await dbRef.child(productName).set(product);

      setState(() {
        isLoading = false;
        _nameController.clear();
        _descController.clear();
        _priceController.clear();
        selectedImage = null;
      });

      _showSnackbar('Product added successfully!');
    } catch (error) {
      // Handle the error
      _showSnackbar('Failed to add product. Please try again.');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color.fromARGB(175, 192, 192, 192),
            height: 1,
          ),
        ),
        title: Text(
          'Add Products',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).push(PageTransition(
              child: const MainScreen(), type: PageTransitionType.fade)),
          child: const Icon(
            IconlyLight.arrow_left,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  MyTextField(
                    controller: _nameController,
                    hintText: 'Add product name',
                    icon: IconlyLight.add_user,
                    isObscure: false,
                    type: TextInputType.name,
                    labelText: 'Product Name',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: _descController,
                    hintText: 'Add product description',
                    icon: IconlyLight.chart,
                    isObscure: false,
                    type: TextInputType.text,
                    labelText: 'Product Description',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: _priceController,
                    hintText: 'Add product price',
                    icon: IconlyLight.buy,
                    isObscure: false,
                    type: TextInputType.text,
                    labelText: 'Product Price', // Set keyboard type to number
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Import(
                    onTap: uploadImage,
                    selectedImage: selectedImage, // Pass the selected image
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    text: 'Submit',
                    background: const Color.fromARGB(255, 163, 147, 219),
                    foreground: Colors.white,
                    onTap: _submitProduct,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
