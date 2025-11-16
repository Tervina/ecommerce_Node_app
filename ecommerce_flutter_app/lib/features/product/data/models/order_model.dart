class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final String paymentMethod;
  final double totalAmount;
  final String fullName;
  final String streetAddress;
  final String city;
  final String phone;
  final String email;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.paymentMethod,
    required this.totalAmount,
    required this.fullName,
    required this.streetAddress,
    required this.city,
    required this.phone,
    required this.email,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["_id"],
      userId: json["user_id"] ?? "",
      items: (json["items"] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      paymentMethod: json["paymentMethod"],
      totalAmount: (json["totalAmount"] as num).toDouble(),
      fullName: json["billingDetails"]["fullName"] ?? "",
      streetAddress: json["billingDetails"]["streetAddress"] ?? "",
      city: json["billingDetails"]["city"] ?? "",
      phone: json["billingDetails"]["phone"] ?? "",
      email: json["billingDetails"]["email"] ?? "",
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json["product_id"],
      productName: json["product_name"],
      quantity: json["quantity"],
      price: (json["price"] as num).toDouble(),
    );
  }
}
