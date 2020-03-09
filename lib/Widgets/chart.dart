import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_app/Widgets/chart_bar.dart';
import '../Objects/transactions.dart';

class Chart extends StatelessWidget {
  final double x=0;
  final List<Transactions> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String,Object>> get statistics{
    return List<Map<String,Object>>.generate(7, (index){
      final time=DateTime.now().subtract(Duration(days:index));
      var daysum=0.0;
      for(int i=0;i<recentTransactions.length;i++){
        if(recentTransactions[i].date.day==time.day &&
        recentTransactions[i].date.month==time.month&&
        recentTransactions[i].date.year==time.year){
          daysum+=recentTransactions[i].price;
        }
      }
      return{
        'date':DateFormat.E().format(time).substring(0,3),
        'amount': daysum
      };
     

    }).reversed.toList();
  }
  double get totalSum{
    return statistics.fold(0, (sum,index){
      return sum+index['amount'];
    });
  }
print()=>totalSum;
  @override
  Widget build(BuildContext context) {
    return Material( child:  Container(
     
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child:
       
        Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
  children:
            
            statistics.map((f){
              
                return Expanded(
                  child: 
                ChartBar(f['date'],f['amount'],totalSum==0?0:(f['amount']as double)/totalSum));
           
            }).toList()             
          ,
            ),
        )
      ),
    ));
  }
}