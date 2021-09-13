import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
final String label;
final double spendingAmount;
final double spendingPercentageOfTotal;
ChartBar(this.label,this.spendingAmount,this.spendingPercentageOfTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){ //layoutbuilder is used to find the height of chart from the constraints
                                                     // and to give it a height that is adjustable to different sizes of devices
       return  Column(
         children: <Widget>[
           Container(
             height: constraints.maxHeight * 0.15,
             child: FittedBox(
                 child: Text('₹${spendingAmount.toStringAsFixed(0)}')
             ),
           ),
           SizedBox(height: constraints.maxHeight * 0.044,),
           Container(height: constraints.maxHeight * 0.65,
             width: 10,
             child: Stack(
               children: <Widget>[
                 Container(
                   decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey, width: 1.0
                       ),
                       color: Color.fromRGBO(220, 220, 220, 1),//each value of color can lie between 0 and 255
                       borderRadius: BorderRadius.circular(10)
                   ),
                 ),
                 FractionallySizedBox(
                   heightFactor: spendingPercentageOfTotal,
                   child: Container(
                     decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                       borderRadius: BorderRadius.circular(10),
                     ),
                   ),
                 ),
               ],
             ),
           ),
           SizedBox(height: constraints.maxHeight * 0.03,),
           Container(height: constraints.maxHeight * 0.10,child: FittedBox(child: Text(label))),
         ],
       );
    },);
  }
}
