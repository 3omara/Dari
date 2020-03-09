import 'package:flutter/material.dart';
import './Widgets/chart.dart';
import './Objects/transactions.dart';
import './Widgets/TransactionsInput.dart';
import './Widgets/transactionsOutput.dart';
void main() {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(MyHomePage());} 

class MyHomePage extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter app',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.orange,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
        textTheme: 
        TextTheme(
          title: TextStyle(fontFamily:'OpenSans',fontSize: 25,fontWeight: FontWeight.bold, color: Colors.white)
        )
        ),
        textTheme: 
        TextTheme(
          title: TextStyle(fontFamily:'OpenSans',fontSize: 25,fontWeight: FontWeight.bold, color: Colors.white),
          headline: TextStyle(fontFamily:'OpenSans',fontSize: 25,fontWeight: FontWeight.bold,color: Colors.orange ),
          body1: TextStyle(fontFamily:'OpenSans', fontSize: 15,fontWeight: FontWeight.bold,color:  Colors.deepOrange  ),
          
        )

      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void panel(BuildContext ctx){
    showModalBottomSheet(
    context: ctx, 
    builder: (_){return GestureDetector( 
      onTap: (){},
      child:TransactionsInput(editing),
      behavior: HitTestBehavior.opaque,); 
      },
    );
   
  }
  bool _switchin=false;
  List<Transactions> transaction =[];
List<Transactions> get _recentTransactions{
  return transaction.where((index){
    return index.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
  }).toList();
}
 void editing(final amount, final title) {
    final x=Transactions(name: title,price: amount, date: DateTime.now(),id: DateTime.now().toString());
   setState(() {
      transaction.add(x);
    });
  } 
  void alert(BuildContext context, String x){
    showDialog(context: context,builder: (context){
return GestureDetector(
  onTap: (){},
 
      child: AlertDialog(content: FlatButton(onPressed:(){setState(() {
      transaction.removeWhere((tx){
        return tx.id==x;
      });
    });
     Navigator.of(context).pop();
    } ,
    child: Text('DELETE',style: Theme.of(context).textTheme.body1,),
    ),
    title: Center(child: Text('Are you sure?',style:Theme.of(context).textTheme.headline)),
    ));
    });

  }
  void delete(String x){
    alert(context, x);

    }

  @override
  Widget build(BuildContext context) {
    final appBar =AppBar(
       actions: <Widget>[
         IconButton(
         icon: Icon(Icons.add),
         onPressed: (){panel(context);},
       )],
        title: Text('Transactions', style: Theme.of(context).appBarTheme.textTheme.title,  
        ) );
    return Scaffold(
      appBar:appBar
      ,
        
      
      body: MediaQuery.of(context).size.height<500?Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Swich Data',style: Theme.of(context).textTheme.body1 ,),
            Switch(value: _switchin,onChanged: (val){
              setState(() {
                _switchin=val;
              });

            },),
          ],
        ),
        _switchin?
         Container(
           height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
           child: Chart(_recentTransactions)):
        
         Container( height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.8,
         child: Stack(
           children:<Widget>[
           TransactionsOutput(transaction,delete),
           Align( 
             alignment: Alignment.bottomCenter,
             child:Padding(
               padding: const EdgeInsets.all(20.0),
               child: FloatingActionButton(
           child: Icon(Icons.add),
           onPressed: (){panel(context);},
         ),
             ))
         ])),
         
         
        ],
      
      ):Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
        
         Container(
           height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.25,
           child: Chart(_recentTransactions)),
        
         Container( height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.75,
         child: Stack(
           children:<Widget>[
           TransactionsOutput(transaction,delete),
           Align( 
             alignment: Alignment.bottomCenter,
             child:Padding(
               padding: const EdgeInsets.all(20.0),
               child: FloatingActionButton(
           child: Icon(Icons.add),
           onPressed: (){panel(context);},
         ),
             ))
         ])),
         
         
        ],
      
      )
    );
  }
}
