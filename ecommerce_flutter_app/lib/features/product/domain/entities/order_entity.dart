// lib/domain/entities/order.dart
class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalAmount;
  final String paymentMethod;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["_id"],
      userId: json["user_id"] ?? "",
      totalAmount: (json["totalAmount"] as num).toDouble(),
      paymentMethod: json["paymentMethod"] ?? "",
      items: (json["items"] as List).map((e) => OrderItem.fromJson(e)).toList(),
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
