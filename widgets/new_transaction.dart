import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;


  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController= TextEditingController();

  DateTime _selectedDate;

  void _submitData()
  {
    if(amountController.text.isEmpty) {
      return;
    }
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);
    if(enterTitle.isEmpty || enterAmount<=0 || _selectedDate==null) {
      return;
    }
        widget.newTx( // by using widget. we can access the properties of different class in some other class
           enterTitle,
            enterAmount,
          _selectedDate
        );

    Navigator.of(context).pop(); //of(context) is required to access the right navigator
                                 //and context is a property that is made available in state class
    }

    void _presentDatePicker(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate) {
          if(pickedDate==null)
            {
              return;
            }
          setState(() {
            _selectedDate=pickedDate;
          });


    });
}

  @override
  Widget build(BuildContext context) {
    return  Card(
    child: Container(
    padding: EdgeInsets.all(10),
child: SingleChildScrollView(
  child:   Card(
    elevation: 5,

    child :Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom:MediaQuery.of(context).viewInsets.bottom+10,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
          TextField(decoration: InputDecoration(labelText: 'title'),
          controller: titleController,
        ),

        TextField(decoration: InputDecoration(labelText: 'amount'),
          controller: amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => _submitData,  //its like dumping the value we get from the submitData function into an underscore
        ),

        Container(
          height: 80,
          child:   Row(children: <Widget>[
            Expanded(

              child: Text(_selectedDate==null?'No Date Chosen':

              'Picked Date : ${DateFormat.yMd().format(_selectedDate)}',
              ),
             ),

            FlatButton(textColor: Theme.of(context).primaryColor ,
                onPressed: _presentDatePicker, child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold))
            )
           ],
          ),
        ),

        RaisedButton(child: Text('Add Transactions'),
            elevation: 5,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white
            ,onPressed: _submitData
              ),
             ],
            ),
    ),

  ),
     ),
    ),
   );
  }
 }
