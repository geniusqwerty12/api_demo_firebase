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