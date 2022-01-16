import 'package:observer/models/stock_direction.dart';

class Stock {
  final double price;
  final double changeAmount;
  final StockChangeDirection stockChangeDirection;

  const Stock({
    required this.price,
    required this.changeAmount,
    required this.stockChangeDirection,
  });
}
