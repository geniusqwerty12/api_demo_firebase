// API Call with Data deserialization
import 'package:flutter/material.dart';
import 'dart:convert';

// For API Calls
import 'package:http/http.dart';

const String productUrl = "https://fir-sample-d3c5d-default-rtdb.asia-southeast1.firebasedatabase.app/products.json";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen()
    );
  }
}

// Use Stateful Widgets for API Calls

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> myProducts = [];

  // We can also use a Future
  Future<dynamic> fetchProducts() {
    Uri productsUri = Uri.parse(productUrl);
    return get(productsUri);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts().then((value) {
      print("Done fetching data!");

      // this data needs to be cleaned
      // to become readable
      
      // convert the JSON data to a list of objects
      List jsonList = json.decode(value.body);
      myProducts = jsonList.map((item){
        return Product.fromJson(item);
      }).toList();
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
//       Unclean way of integrating APIS
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

class Product {
  // Class attributes that matches the API response
  int? id;
  String? brand;
  String? category;
  String? description;
  String? title;
  String? thumbnail;
  double? discountPercentage;
  List<String>? images;
  double? price;
  double? rating;
  int? stock;

  // Constructor
  Product({this.id, this.brand, this.category, this.description, this.title, this.thumbnail,
    this.discountPercentage, this.images, this.price, this.rating, this.stock});

  // Converting Map items to this class objects
  Product.fromJson(Map<String, dynamic> json){
    // make sure that the keys you are referring matches the ones present in the response
    id = json['id'];
    brand = json['brand'];
    category = json['category'];
    description = json['description'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    discountPercentage = json['discountPercentage'];
    price = json['price'];
    rating = json['rating'];
    stock = json['stock'];
  }
}