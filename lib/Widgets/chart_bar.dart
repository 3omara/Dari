import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPct;
  ChartBar(this.label,this.spendingAmount,this.spendingPct);
  
  @override
  Widget build(BuildContext context) {
  return LayoutBuilder(builder: (ctx,constraint){
return Row(
      
      children: <Widget>[
        
        Padding (
          padding: EdgeInsets.all(5),
                  child: Column(
            
            children: 
            
            <Widget>[
              
               Container(
                 height: constraint.maxHeight*0.1,width:(constraint.maxWidth)*0.4,
                 child:                             
                   FittedBox (
                   child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
               ),
              SizedBox(height: constraint.maxHeight*0.05,),
              Container(
                 height: constraint.maxHeight*0.5,width:constraint.maxWidth*0.2,
                  
                child: Stack(
                  
                  children: <Widget>[
                    Container( 
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(width: 10,color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    ),
                    Align( 
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                      
                      heightFactor: spendingPct,child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ))
                  ],
                ),
              ),  SizedBox(height: constraint.maxHeight*0.05,),
              Container(height: (constraint.maxHeight)*0.1,width:(constraint.maxWidth)*0.4,
                child: FittedBox (alignment: Alignment.center,child: Text(label)))
            ],

          ),
        ),
       
      ],
    );
    },);
    
  }
}