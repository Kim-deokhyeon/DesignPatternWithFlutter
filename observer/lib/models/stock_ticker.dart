import 'dart:async';

import 'package:faker/faker.dart';
import 'package:meta/meta.dart';

import 'stock_direction.dart';
import 'stock.dart';
import 'stock_subscriber.dart';

abstract class StockTicker {
  late final String title;
  late final Timer stockTimer;

  @protected
  Stock? stock;

  final _subscribers = <StockSubscriber>[];

  void subscribe(StockSubscriber subscriber) => _subscribers.add(subscriber);

  void unsubscribe(StockSubscriber subscriber) =>
      _subscribers.removeWhere((s) => s.id == subscriber.id);

  void notifySubscribers() {
    for (final subscriber in _subscribers) {
      subscriber.update(stock!);
    }
  }

  void setStock(int min, int max) {
    final price = faker.randomGenerator.integer(max, min: min) / 100;
    final changeAmount = stock != null ? price - stock!.price : 0.0;
    final stockChangeDirection = changeAmount > 0
        ? StockChangeDirection.growing
        : StockChangeDirection.falling;

    stock = Stock(
      price: price,
      changeAmount: changeAmount.abs(),
      stockChangeDirection: stockChangeDirection,
    );
  }

  void stopTicker() {
    stockTimer.cancel();
  }
}
