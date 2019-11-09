import 'package:flutter/material.dart';

class CalculatorHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalculatorHomeState();
  }
}

class CalculatorHomeState extends State<CalculatorHome> {
  var _formKey = GlobalKey<FormState>();
  final minimumPadding = 10.0;
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var currentItemSelected;
  TextEditingController principalController = new TextEditingController();
  TextEditingController interestController = new TextEditingController();
  TextEditingController termController = new TextEditingController();
  String result = "";

  @override
  void initState() {
    super.initState();
    currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Interest Calculator"),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.all(minimumPadding),
                child: ListView(
                  children: <Widget>[
                    getImageAsset(),
                    Padding(
                        padding: EdgeInsets.all(minimumPadding),
                        child: TextFormField(
                          // ignore: missing_return
                          validator: (String input) {
                            if (input.isEmpty) {
                              return "Please enter principal amount";
                            }
                          },
                          controller: principalController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 15.0),
                              labelText: "Principal amount",
                              hintText: "Enter amount",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                    Padding(
                      padding: EdgeInsets.all(minimumPadding),
                      child: TextFormField(
                          validator: (String input) {
                            if (input.isEmpty) {
                              return "Please enter rate of interest amount";
                            }
                          },
                          controller: interestController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 15.0),
                              labelText: "Rate of interest",
                              hintText: "In percent",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)))),
                    ),
                    Padding(
                        padding: EdgeInsets.all(minimumPadding),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter terms';
                                }
                              },
                              controller: termController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.red, fontSize: 15.0),
                                  labelText: 'Enter Term',
                                  hintText: 'Time in years',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            )),
                            Container(
                              width: minimumPadding * 5,
                            ),
                            Expanded(
                                child: DropdownButton<String>(
                              items: _currencies.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: currentItemSelected,
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  currentItemSelected = newValueSelected;
                                });
                                // Your code to execute, when a menu item is selected from dropdown
                              },
                            ))
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.all(minimumPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              child: Text("Calculate"),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    calculateTotalReturn();
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(width: minimumPadding * 2),
                          Expanded(
                            child: RaisedButton(
                              child: Text("Reset"),
                              onPressed: () {
                                setState(() {
                                  principalController.text = '';
                                  interestController.text = '';
                                  termController.text = '';
                                  result = '';
                                  currentItemSelected = _currencies[0];
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(minimumPadding),
                      child: Text("Total amount is: " + result),
                    )
                  ],
                ))));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("assets/images/flutter_logo.png");
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(minimumPadding * 5),
    );
  }

  String calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(interestController.text);
    double term = double.parse(termController.text);
    double amount = principal + (principal * roi * term) / 100;
    result = "$amount";
    return result;
  }
}
