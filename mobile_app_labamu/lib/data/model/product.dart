class Product {
  late dynamic id;
  late String? name;
  late String? description;
  late int? price;
  late String? imageUrl;
  late String? status;
  late String? updatedAt;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.status,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      status: json['status'],
      updatedAt: json['updatedAt'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'status': status,
      'updatedAt': updatedAt,
    };
  }
}
