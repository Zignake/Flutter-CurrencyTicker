import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


const String apiKey = '79AA6E88-1A0D-44DD-BE23-4E0C2097D109';

class GetRates {
  Future getRate(String crypto, String currency) async {
    http.Response response = await http.get('https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apiKey');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var rate = data['rate'];
      return rate;
    } else {
      print(response.statusCode);
    }
  }
}