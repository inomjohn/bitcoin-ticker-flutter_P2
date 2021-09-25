import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

String selectedCurrency = 'USD';

class _PriceScreenState extends State<PriceScreen> {
  List<String> coinPrices;
  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropdownItem = [];
    for (String currency in currenciesList) {
      var newItems = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItem.add(newItems);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItem,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  String bitcoinValuePrice = '?';
  String etheriumValuePrice = '?';
  String litecointValuePrice = '?';

  Future<void> getData() async {
    try {
      double BTCprice = await CoinData().getCoinData("BTC", selectedCurrency);
      double ETCprice = await CoinData().getCoinData("ETC", selectedCurrency);
      double LTCprice = await CoinData().getCoinData("LTC", selectedCurrency);

      setState(() {
        bitcoinValuePrice = BTCprice.toStringAsFixed(0);
        etheriumValuePrice = ETCprice.toStringAsFixed(0);
        litecointValuePrice = LTCprice.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coinPrices = [bitcoinValuePrice, etheriumValuePrice, litecointValuePrice];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cryptoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${cryptoList[index]} = ${coinPrices[index]} $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
