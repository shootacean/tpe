import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Three Point Estimate',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
      ),
      home: ThreePointEstimatePage(),
    );
  }
}

class ThreePointEstimatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThreePointEstimateState();
}

class _ThreePointEstimateData {
  int standard = 0;
  int pessimistic = 0;
  int optimistic = 0;
}

class _ThreePointEstimateState extends State<ThreePointEstimatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _ThreePointEstimateData _data = _ThreePointEstimateData();

  String _answer = '';
  final TextEditingController _answerController =
      TextEditingController(text: '');

  void initState() {
    super.initState();

    _answerController.addListener(() {
      setState(() {
        _answer = _answerController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Three Point Estimate'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration:
                    InputDecoration(hintText: '8', labelText: 'Standard'),
                onSaved: (String value) {
                  try {
                    this._data.standard = int.parse(value);
                  } catch (exception) {
                    this._data.standard = 0;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration:
                    InputDecoration(hintText: '24', labelText: 'Pessimistic'),
                onSaved: (String value) {
                  try {
                    this._data.pessimistic = int.parse(value);
                  } catch (exception) {
                    this._data.pessimistic = 0;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration:
                    InputDecoration(hintText: '3', labelText: 'Optimistic'),
                onSaved: (String value) {
                  try {
                    this._data.optimistic = int.parse(value);
                  } catch (exception) {
                    this._data.optimistic = 0;
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: screenSize.width,
                child: RaisedButton(
                  child: Text('Calc',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: this.calc,
                  color: Colors.blue,
                ),
              ),
              Container(
                child: TextField(
                  readOnly: true,
                  controller: _answerController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calc() {
    _formKey.currentState.save();
    final double answer =
        ((_data.standard * 4) + _data.pessimistic + _data.optimistic) / 6;
    _answerController.text = answer.toString();
  }
}
