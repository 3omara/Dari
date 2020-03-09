import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 
class TransactionsInput extends StatefulWidget {
  final Function funn;
  TransactionsInput(this.funn);

 
  @override
  _TransactionsInputState createState() => _TransactionsInputState();
}

class _TransactionsInputState extends State<TransactionsInput> {
  final titlevar = TextEditingController();
  DateTime datetimevar;
  final amountvar = TextEditingController();

  void parsin(){
    final y = titlevar.text;
    double x = double.parse(amountvar.text);
    if(x<=0||titlevar.text.isEmpty){
return;
    }else{
      widget.funn(x,y);
      Navigator.of(context).pop();
    }
  }
void _datePickin(){
  showDatePicker(context:context, firstDate:DateTime.now(),initialDate: DateTime(2020),lastDate: DateTime.now()).then((val){
       if(val ==Null){
         return;
       }else{
          datetimevar=val;
       }
  });}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
            child: Container(
                padding: EdgeInsets.only(top:10,left: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom+10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
               TextField(
                 decoration: InputDecoration(labelText: 'Title'),
                 controller: titlevar,
                 onSubmitted: (_){parsin();},
               ),
               TextField(
                 decoration: InputDecoration(labelText: 'Amount'),
                 controller: amountvar,
                 keyboardType: TextInputType.number,
                 onSubmitted: (_){parsin();},
                
               ),Container(
                 child: Row(
                   children: <Widget>[
                     Text('Choose Date'),
                     FlatButton(
                      child: Text('Date'),
                       onPressed:  _datePickin,
                     ),
                   ],
                 ),
               ),
               FlatButton(
                 child: Text('Add Transaction'),
                
                 onPressed: parsin,
               ),
              ],),
        ),
      ),
    );
  }
}