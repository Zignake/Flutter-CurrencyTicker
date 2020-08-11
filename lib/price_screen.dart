import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'coin_data.dart';
import 'widget_displayBox.dart';
import 'get_rates.dart';


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  List<String> itemsList = currenciesList;
  String dropdownValue = 'USD';
  String rateBTC;
  String rateETH;
  String rateLTC;

  GetRates getRates = GetRates();

  @override
  void initState() {
    super.initState();
    print(cryptoList[0]);
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
          DisplayBox(cryptoCurrency: 'BTC', normalCurrency: dropdownValue, rate: rateBTC,),
          DisplayBox(cryptoCurrency: 'ETH', normalCurrency: dropdownValue, rate: rateETH,),
          DisplayBox(cryptoCurrency: 'LTC', normalCurrency: dropdownValue, rate: rateLTC,),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.white
              ),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String newValue) async{
                double newRateBTC = await getRates.getRate('BTC', newValue)*1.00;
                double newRateETH = await getRates.getRate('ETH', newValue)*1.00;
                double newRateLTC = await getRates.getRate('LTC', newValue)*1.00;
                setState(() {
                  dropdownValue = newValue;
                  rateBTC = newRateBTC.toStringAsFixed(2);
                  rateETH = newRateETH.toStringAsFixed(2);
                  rateLTC = newRateLTC.toStringAsFixed(2);
                });
              },
              items: itemsList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
