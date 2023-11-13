import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      print(value);
      // this data needs to be cleaned
      // to become readable

      // This response object is similar
      // to an http response, header, body
      print(value.body);

      // jsonDecode to
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
          Text("PRODUCT LIST"),

          // we can do it 2 ways
        ],
      ),
    );
  }
}
