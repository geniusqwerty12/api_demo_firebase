// Using Futures to fetch Data
import 'package:flutter/material.dart';

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
  String response = "";

  // We can also use a Future
  Future<dynamic> fetchProducts() {
    Uri productsUri = Uri.parse(productUrl);
    return get(productsUri);
  }

  // The async keyword
  // signifies that this is an asynchronous method
  void fetchProducts2() async {
    // We can provide the full link for the API
    Uri productsUri = Uri.parse(productUrl);
    Response res = await get(productsUri);
    response = res.body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts().then((value) {
      print("Done fetching data!");

      // this data needs to be cleaned
      // to become readable

      // This response object is similar
      // to an http response, header, body
      // print(value.body); 
      response = value.body;

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
      body: Column(
        children: [
          Text(response),
        ]
      ),
    );
  }
}