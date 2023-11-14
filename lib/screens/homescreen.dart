import 'dart:convert';

import 'package:api_demo_firebase/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String response = "";
  // List to store the data coming from 
  List<Product> myProducts = [];

  // We can also use a Future
  Future<dynamic> fetchProducts() {
    Uri productsUri = Uri.parse(
        "https://fir-sample-d3c5d-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
    return http.get(productsUri);
  }

  // The async keyword
  // signifies that this is an asynchronous method
  void fetchProducts2() async {
    // We can provide the full link for the API
    Uri productsUri = Uri.parse(
        "https://fir-sample-d3c5d-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");

    await http.get(productsUri);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts().then((value) {
      print("Done fetching data!");
      // print(value);
      // this data needs to be cleaned
      // to become readable

      // This response object is similar
      // to an http response, header, body
      // print(value.body); 
      response = value.body;

      // we assume that the body is a list of Map
      // print(value.body.length);

      // convert the JSON data to a list of objects
      List jsonList = json.decode(value.body);
      myProducts = jsonList.map((item){
        return Product.fromJson(item);
      }).toList();
      print(myProducts[0].id);
      setState(() {
        
      });

    }).catchError((error) {
      print("Error fetching data!");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Testing"),
      ),
      body: ListView.builder(
            itemCount: myProducts.length,
            itemBuilder: (context, index) {
              final item = myProducts[index];
              return ListTile(
                leading: Image.network(item.thumbnail!),
                title: Text(item.title!),
                subtitle: Text('PHP ${item.price}'),
              );
            },
          ),
      );
  }
}
