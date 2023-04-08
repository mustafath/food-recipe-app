class Ingredient {
  final String id;
  final String name;

  final int quantity;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }

  static Ingredient fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
    );
  }
}
