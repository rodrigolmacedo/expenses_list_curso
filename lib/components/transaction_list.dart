import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tr = transactions[index];
                return Card(
                    child: Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text('R\$ ${tr.value.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headline5)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tr.tittle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          DateFormat('d MMM y').format(tr.date),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )
                  ],
                ));
              },
            ),
    );
  }
}
