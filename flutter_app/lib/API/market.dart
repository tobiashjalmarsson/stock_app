import './stock.dart';

class Market {
  List<Stock> _stocks = [];

  Market();

  // Below function is for testing purposes
  void populateMarket(){
    Stock test1 = new Stock(name: "Apple", dChange: 2.1, yChange: 4.1);
    Stock test2 = new Stock(name: "Google", dChange: 3.8, yChange: 14);
    Stock test3 = new Stock(name: "Facebook", dChange: -2.8, yChange: -39);
    _stocks.add(test1);

    /*
    List<String> names = ["Apple", "Google", "Facebook", "Tesla", "Amazon", "Ericsson"];
    List<double> dChanges = [-1.23, 0.2, 0.45, -3.8, 10.1, 2.22];
    List<double> yChanges = [-12.1, 8.2, -2.8, 732.8, 34.2, 12.3];
    for(int i = 0; i < 2; i++){
      Stock currentStock = Stock(name : names[i], dChange: dChanges[i], yChange: yChanges[i]);
      addStock(currentStock);
    }*/
  }



  void addStock(Stock stock) {
    _stocks.add(stock);
  }

  void deleteStock(Stock stock) {
    for (Stock st in _stocks) {
      if (st.name == stock.name) {
        _stocks.remove(st);
      }
    }
  }

  List<Stock> getStocks(){
    return _stocks;
  }
}