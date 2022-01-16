import 'package:observer/models/stock_subscriber.dart';

import '../stock.dart';

class MainStockSubscriber extends StockSubscriber {
  MainStockSubscriber() {
    title = 'Main';
  }

  @override
  void update(Stock stock) {
    stockStreamController.add(stock);
  }
}
