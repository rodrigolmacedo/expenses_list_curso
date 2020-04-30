import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({Key key, this.label, this.value, this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 20.0,
            child: FittedBox(
              child: Text(NumberFormat.currency(
                      locale: 'pt_BR', symbol: '', decimalDigits: 2)
                  .format(value)
                  .toString()),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: percentage ?? 0,
                    widthFactor: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(label)
        ],
      ),
    );
  }
}
