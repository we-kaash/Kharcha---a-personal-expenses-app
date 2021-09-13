import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


class TransactionList extends StatelessWidget {
final Function deleteTx;

final List<Transaction> transactions;
TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty?
          LayoutBuilder(builder: (ctx,constraints){
        return Column(
        children: <Widget>[
        Text('No transaction added yet!',
      style: Theme.of(context).textTheme.title,
    ),
    SizedBox(
    height: 10,
    ),
    Container(
    height: constraints.maxHeight*0.8,
    child: Image.asset('assets/images/waiting.png',
    fit: BoxFit.cover,
    )
    )
    ],
    );
      })
        :
        ListView.builder(
          itemBuilder: (ctx,index) {
               return Card( // alternative of this list is custom list which we replaced with this cardwe can find the custom list from this given link : https://ide.codingblocks.com/s/583999
                 elevation: 5,
                 margin: EdgeInsets.symmetric(vertical: 8,horizontal: 6),
                 child: ListTile(
                   leading: CircleAvatar(radius: 40,
                   child: Padding(
                       padding: EdgeInsets.all(15),
                       child: FittedBox(child: Text('${transactions[index].amount}Rs'))),
                   ),
                   title: Text(transactions[index].title,style: Theme.of(context).textTheme.title,), //we can use headline6 instead of title
                   subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)
                   ),
                   trailing: MediaQuery.of(context).size.width > 460 ? FlatButton.icon(
                     textColor:Theme.of(context).errorColor,
                     icon: Icon(Icons.delete),
                     label: Text('Delete'),
                     onPressed: () => deleteTx(transactions[index].id),
                   )
                       : IconButton(icon : Icon(Icons.delete),
                   color: Theme.of(context).errorColor,
                     onPressed: () => deleteTx(transactions[index].id),
                   ),
                 ),
               );

          }, // it calls the function evrytime for every new item to render on the screen
          itemCount: transactions.length,

        ),

    );

  }
}
