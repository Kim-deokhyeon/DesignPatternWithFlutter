import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:observer/models/observer.dart';
import 'package:observer/stock_ticker_model.dart';

import 'widgets/stock_row.dart';

class ObserverExample extends StatefulWidget {
  const ObserverExample({Key? key}) : super(key: key);

  @override
  _ObserverExampleState createState() => _ObserverExampleState();
}

class _ObserverExampleState extends State<ObserverExample> {
  final _stockTickers = StockTickerModel(stockTicker: MainStockTicker());
  final _stockEntries = <Stock>[];

  StreamSubscription<Stock>? _stockStreamSubscription;
  final StockSubscriber _subscriber = MainStockSubscriber();

  void _onStockChange(Stock stock) {
    setState(() {
      _stockEntries.add(stock);
    });
  }

  void _toggleStockTickerSelection() {
    final stockTickerModel = _stockTickers;
    final stockTicker = stockTickerModel.stockTicker;

    if (stockTickerModel.subscribed) {
      stockTicker.unsubscribe(_subscriber);
    } else {
      stockTicker.subscribe(_subscriber);
    }

    setState(() {
      stockTickerModel.toggleSubscribed();
    });
  }

  @override
  void initState() {
    super.initState();

    _stockStreamSubscription = _subscriber.stockStream.listen(_onStockChange);

    final stockTickerModel = _stockTickers;
    final stockTicker = stockTickerModel.stockTicker;

    stockTicker.subscribe(_subscriber);

    setState(() {
      stockTickerModel.toggleSubscribed();
    });
  }

  @override
  void dispose() {
    _stockTickers.stockTicker.stopTicker();
    _stockStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Text('Observer Pattern 예제'),
                const SizedBox(width: 50),
                MaterialButton(
                  onPressed: _toggleStockTickerSelection,
                  child: Text(_stockTickers.subscribed ? '멈춤' : '계속'),
                )
              ],
            ),
            ..._stockEntries.reversed.map(
              (stock) => StockRow(stock: stock),
            ),
          ],
        ),
      ),
    );
  }
}
