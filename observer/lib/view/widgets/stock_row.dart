import 'package:flutter/material.dart';
import 'package:observer/models/observer.dart';

class StockRow extends StatelessWidget {
  const StockRow({required this.stock, Key? key}) : super(key: key);
  final Stock stock;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '현재 : ' + stock.price.toStringAsFixed(2),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Icon(
                stock.stockChangeDirection == StockChangeDirection.growing
                    ? Icons.arrow_upward_outlined
                    : Icons.arrow_downward_outlined,
                color:
                    stock.stockChangeDirection == StockChangeDirection.growing
                        ? Colors.red
                        : Colors.blue,
              ),
              Text(' ' + stock.changeAmount.toStringAsFixed(2)),
            ],
          ),
        ),
      ],
    );
  }
}
