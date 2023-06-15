import 'package:http/http.dart'as http;
import 'dart:convert';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future getCoinData(String selectedCurrency) async{
    final response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=A535AC1A-9962-4D33-BE6C-01A6B88F8234'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200){
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;

    }
    else{
      throw('problem with get request');
    }

  }
}