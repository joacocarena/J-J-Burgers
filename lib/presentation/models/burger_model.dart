class Burger {
  String name;
  String description;
  double price;

  factory Burger.fromJson(Map<String, dynamic> json) {
    return Burger(
      name: json['name'], 
      description: json['description'], 
      price: json['price']
    );
  }

  Burger({
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price
    };
  }

}