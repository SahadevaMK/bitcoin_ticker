import 'dart:convert';
import 'CoinPrice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart'as http;
import 'coin_data.dart';
class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  late String selectedCurrency = "AUD";


  DropdownButton<String> androidDropDown(){

    List<DropdownMenuItem<String>> dropMenuItem = [];
    for (int i = 0;i<currenciesList.length;i++){
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(value: currency,child: Text(currency),);
      dropMenuItem.add(newItem);
    }
    getData();
    return DropdownButton(
      value: selectedCurrency,
      onChanged: (value){
        setState(() {
          selectedCurrency = value!;
        });
      },
      items: dropMenuItem,
    );

  }

  CupertinoPicker iOSPicker(){
    List<Text> iOSPickerText = [];
    for (String s in currenciesList){
      iOSPickerText.add(Text(s));
    }
    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged:(int value){print(value);},
        children: iOSPickerText
    );
  }
  StatefulWidget getPicker(){
    if(Platform.isIOS){
      return iOSPicker();
    }else if(Platform.isAndroid){
      return androidDropDown();
    }
    throw();
  }

  String bitCoinInUsd = '?';
  void getData()async{
    try {
      double data = await CoinData().getCoinData(selectedCurrency);
      setState(() {
        bitCoinInUsd = data.toStringAsFixed(0);
      });
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC =  $bitCoinInUsd $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidDropDown(),
          ),
        ],
      ),
    );
  }

}
