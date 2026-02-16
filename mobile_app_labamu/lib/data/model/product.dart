class Product {
  late int? id;
  late String? name;
  late String? description;
  late double? price;
  late String? status;
  late String? updatedAt;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.status,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      status: json['status'],
      updatedAt: json['updated_at'],
    );
  }
}
