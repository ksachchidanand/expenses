import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(
    this.userTransactions,
    this.deleteTransaction,
  );

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.15,
                    child: Text(
                      'No transaction added yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    child: Image.asset(
                      'images/waiting.png',
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 3,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\$${userTransactions[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransactions[index].name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(userTransactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            onPressed: () =>
                                deleteTransaction(userTransactions[index].id),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            style: ButtonStyle(
                                foregroundColor: MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).errorColor)),
                          )
                        : IconButton(
                            color: Theme.of(context).errorColor,
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                deleteTransaction(userTransactions[index].id),
                          ),
                  ),
                ),
              );
            },
            itemCount: userTransactions.length,
          );
  }
}
