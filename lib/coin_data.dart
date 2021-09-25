import 'dart:convert';
import 'package:http/http.dart' as http;

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '0960DBA4-F590-44C4-868A-524E096C0329';

class CoinData {
  Future<double> getCoinData(String bitcoin, String currency) async {
    String requestURL =
        '$coinAPIURL/$cryptoList/$currenciesList?apikey=$apiKey';
    http.Response response = await http.get(
      Uri.parse(requestURL),
    );

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      //String change1 = decodedData(data)['asset_id_base'];
      //String change2 = decodedData(data)['asset_id_quote'];

    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}

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
