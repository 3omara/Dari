import 'package:flutter/material.dart';
import 'package:real_app/Objects/transactions.dart';
import 'package:intl/intl.dart';
class TransactionsOutput extends StatelessWidget{
  final List<Transactions> trans;  
  final Function deletetx;
  TransactionsOutput(this.trans,this.deletetx);

  @override
  Widget build(BuildContext context) {
   
 return LayoutBuilder(
   builder: (ctx,constraint){
   return  Container(
     
      
      child:
      trans.isEmpty?
                    Column( 
                    
                    children:<Widget>[ 
                     
          Text('No record of previous transactions',style: Theme.of(context).textTheme.body1,),
          SizedBox(
            height:30 , 
          ),
          Align(
            alignment: Alignment.center,
            child:Container(height:constraint.maxHeight*0.5,child: Image.asset('images/cloud_PNG14.png',fit: BoxFit.cover,)))
          ]
          )
          : 
       ListView.builder(
         
        itemBuilder: (ctx,index){
      
        return Card(
          margin: EdgeInsets.all(8),
                  elevation: 8,
                  child: ListTile(
          leading: CircleAvatar(radius: 30,child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(child: Text('\$${trans[index].price}')),
          ),) ,
          title: Text('${trans[index].name}'),
          trailing: FittedBox(child:
          IconButton(icon: Icon(Icons.delete),
          onPressed:()=>deletetx(trans[index].id) , ) ,),
          subtitle: Text('${DateFormat.yMd().format(trans[index].date)}'),
          ),
        );
        },
        itemCount: trans.length,
              
            ),
    );
   },
 );
    
 
  }
}