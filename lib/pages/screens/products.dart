import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:learn_flutter/pages/screens/product_page.dart';
import 'package:learn_flutter/widgets/card.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({Key? key}) : super(key: key);

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  Query dbRef = FirebaseDatabase.instance.ref().child('products');
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    dbRef.once().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color.fromARGB(255, 192, 192, 192),
            height: 1,
          ),
        ),
        title: const Text(
          'Products',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: const Icon(
          IconlyLight.arrow_left,
          color: Colors.black,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 26.0),
            child: Icon(
              IconlyLight.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (context, snapshot, animation, index) {
                  Map product = snapshot.value as Map;
                  product['key'] = snapshot.key;
                  int? price = int.tryParse(product['price']?.toString() ?? '');
                  int? count = int.tryParse(product['count']?.toString() ?? '');

                  return MyCard(
                    name: product['name']?.toString() ?? '',
                    price: price.toString(),
                    desc: product['desc']?.toString() ?? '',
                    image: product['image']?.toString() ?? '',
                    count: count.toString(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(
                            productName: product['name']?.toString() ?? '',
                            productPrice: price.toString(),
                            productDescription:
                                product['desc']?.toString() ?? '',
                            productImage: product['image']?.toString() ?? '',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
