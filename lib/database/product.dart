class Product {
  String id;
  String name;
  String description;
  double price;
  String image;
  String category;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'price': price,
    };
  }


  factory Product.fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['name'],
      description: data['description'],
      price: data['price'],
      image: data['image'],
      category: data['category'],
    );
  }
}
