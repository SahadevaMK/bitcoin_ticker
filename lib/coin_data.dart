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

  Future getCoinData() async{
    final response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/USD/?apikey=1CF03DBF-E696-413C-BEB3-59088AF522EF'));
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