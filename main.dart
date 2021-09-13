import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kharcha/widgets/new_transaction.dart';
import 'package:kharcha/widgets/transaction_list.dart';
import 'widgets/chart.dart';
import './models/transaction.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app',
      home: MyHomePage(),
      theme:  ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith( // this is for the title in the list of transactions we have
          headline6: TextStyle(         //as title was depricated so we changed this headline6 property instead
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )
        ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(  //this is slightly different from the above theme and is for appbar only
                headline6: TextStyle(   //as title was depricated so we changed this headline6 property instead
          fontFamily: 'OpenSans',
           fontSize: 20,
          fontWeight: FontWeight.bold,
        ))

        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final List<Transaction> _userTransaction = [
  /*  Transaction(
        id: 't1',
        title: 'New shoes',
        amount: 2500,
        date: DateTime.now()
    ),
    Transaction(
        id: 't2',
        title: 'Domino\'s pizza',
        amount: 700.81,
        date: DateTime.now()
    ), */
  ];

  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
          DateTime.now().subtract(
              Duration(days: 7),
          ),
       );
    }).toList();
  }


  void _addTransaction(String txTitle,double txAmount,DateTime chosenDate)
  {    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString()
  );

  setState(() {
    _userTransaction.add(newTx);
  });
  }


  void _startAddTransaction(BuildContext ctx) // it starts the process or we can say it shows the area to add a new transaction
  {                                           // we already got the value of context in the build method so we just accept it here to give
                                              // to showModalBottomSheet widget
    showModalBottomSheet(context: ctx, builder: (_)
    {
     return GestureDetector(
     //  onTap: (){} ,
       child:NewTransaction(_addTransaction),
       //behavior: HitTestBehavior.opaque,
     );

     },
    );
  }
  void _deleteTransaction(String id)
  {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id );
    });
  }

  @override
  Widget build(BuildContext context) {

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;



    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add), onPressed: ()=> _startAddTransaction(context) )
      ],
    );

    final txListWidget = Container(height: (MediaQuery.of(context).size.height -
        appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.75,
        child: TransactionList(_userTransaction, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              if(isLandscape)Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text('show chart'),
              Switch.adaptive(value: _showChart,onChanged: (val)
                {
                  setState(() {
                    _showChart=val;
                  });

                },)],),

            if(!isLandscape)
             Container(height: (MediaQuery.of(context).size.height -
                 appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.3  ,
                 child: Chart(_recentTransactions)),
            if(!isLandscape) txListWidget,
            if(isLandscape)
            _showChart? Container(height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.8  ,
              child: Chart(_recentTransactions))

              : txListWidget,

        ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ?
      Container() : FloatingActionButton(child: Icon(Icons.add),
        onPressed: ()=>_startAddTransaction(context),),
    );
  }
}

