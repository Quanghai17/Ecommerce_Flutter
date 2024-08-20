class OrderItem {
  final int productId;
  final int quantity;
  final int price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}

class Order {
  final int id;
  final int userId;
  final int totalAmount;
  final String shippingAddress;
  final String name;
  final String email;
  final String phone;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.shippingAddress,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      totalAmount: json['totalAmount'],
      shippingAddress: json['shippingAddress'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
