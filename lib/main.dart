import 'package:flutter/material.dart';


void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator App',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    )
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm>{
  var _currencies= ['Rupees','Dollars','Pounds'];
  final _minimumpadding=5.0;
  var _formKey= GlobalKey<FormState>();

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult='';
    var _currentItemSelected= '';

  @override
  void initState(){
    super.initState();
    _currentItemSelected= _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle= Theme.of(context).textTheme.display1;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        //margin: 
        child: Padding(
          padding:EdgeInsets.all(_minimumpadding*2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: _minimumpadding, bottom: _minimumpadding),
              child: TextFormField(
              keyboardType: TextInputType.number,
              style: textStyle,
              controller: principalController,
              validator: (String value){
                if (value.isEmpty){
                  return 'Please enter principle amount';
                }
              },
              decoration: InputDecoration(
                labelText: 'Principal',
                hintText: 'Enter principal e.g.12000',
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 15.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minimumpadding,bottom: _minimumpadding),
            child: TextFormField(
              keyboardType:TextInputType.number,
              style: textStyle,
              controller: roiController,
              validator: (String value){
                if(value.isEmpty){
                  return 'Please enter rate of interest';
                }
              },
              decoration: InputDecoration(
                labelText: 'Rate of interest',
                labelStyle: textStyle,
                hintText: 'In percent',
                errorStyle: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 15.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),)
            ),
            Padding(
              padding: EdgeInsets.only(top: _minimumpadding, bottom: _minimumpadding),
              child: Row(              
              children: <Widget>[
          Expanded(child: TextFormField(
              keyboardType:TextInputType.number,
              controller: termController,
              validator: (String value){
                if (value.isEmpty){
                  return 'Please enter term';
                }
              },
              decoration: InputDecoration(
                labelText: 'Term',
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 15.0,
                ),
                hintText: 'Time in years',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
              ),     
          ),
          Container(width: _minimumpadding*5,),
              Expanded(child: DropdownButton<String>(
                items: _currencies.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value) ,
                    );
                }).toList(),

                value: _currentItemSelected,
                onChanged: (String newValueSelected){
                  _onDropDownItemSelected(newValueSelected);
                },
              ) 
              ),
                     
              ],
            )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: _minimumpadding,top: _minimumpadding),
              child: Row(children: <Widget>[
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColorDark,
                  child: Text('Calculate',style: textStyle,textScaleFactor: 1.1,),
                  onPressed: (){

                    setState((){
                      if(_formKey.currentState.validate()){
                      this.displayResult=_calculatorTotalReturns();
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text('Reset',style: textStyle,textScaleFactor: 1.1,),
                  onPressed: (){
                    setState(() {
                       _reset();
                    });
                  },
                ),
              ),
            ],)
            ),
            Padding(
              padding: EdgeInsets.all(_minimumpadding*2),
              child: Text(this.displayResult,style: textStyle,),
            )
          ],
        ),
        )
      ),
    );
  }

  Widget getImageAsset(){
    AssetImage assetImage=AssetImage('images/DeutscheBank.gif');
    Image image= Image(image: assetImage,width: 125.0,height: 125.0,);
    
    return Container(child: image,margin: EdgeInsets.all(_minimumpadding*10),);
  }
  void _onDropDownItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculatorTotalReturns(){
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term= double.parse(termController.text);

    double totalAmountPayable = principal + (principal*roi*term)/100;

    String result ='After $term years, your investment will be worth $totalAmountPayable';
    return result;

  }

  void _reset(){
    principalController.text='';
    roiController.text='';
    termController.text='';
    displayResult='';
    _currentItemSelected=_currencies[0];  
}
}

