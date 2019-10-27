import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunger_preventer/screens/transaction_list/transaction_list_state.dart';

class TransactionList extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    if (_transactionList == null) {
      return new Container();
    }

    var balanceRepository = BalanceSnapshotRepository();
    var balanceIntegrityChecker = BalanceIntegrityChecker();

    var transactionRepository = TransactionRepository();


    List<Widget> children = List();
    transactionRepository.get(DateTime.now()).then((transactions) {



    });


    var balanceSnapshots = balanceRepository.get(DateTime.now());

    int balance;
    transactions.sortBy(TransactionListSorting.DateAscending);

    for (var i = 0; i < balanceSnapshots.length; i++) {
      var isCurrentSnapshot = (i + 1 == balanceSnapshots.length);
      var snapshot = balanceSnapshots[i];
      balance = snapshot.balance;

      children.add(
        Divider(
          color: Colors.black,
          height: 20,
          thickness: 10,
        ),
      );
      children.add(
        Text(snapshot.toString(),
            style: TextStyle(
              backgroundColor: Colors.amber,
            )),
      );

      if (!isCurrentSnapshot) {
        var nextSnapshot = balanceSnapshots[i + 1];
        var currentTransactions =
        transactions.getTransactions(snapshot.date, nextSnapshot.date);
        var offset = balanceIntegrityChecker.calculateOffset(
            snapshot, nextSnapshot, currentTransactions);

        for (var y = 0; y < currentTransactions.length; y++) {
          var style = (currentTransactions[y].amount > 0)
              ? TextStyle(backgroundColor: Colors.green)
              : TextStyle(backgroundColor: Colors.red);
          children.add(Text(
            currentTransactions[y].toString(),
            style: style,
          ));
          balance += currentTransactions[y].amount;
          children.add(Text(
            ShadowAccountBalance(balance, currentTransactions[y].date)
                .toString(),
            style: TextStyle(backgroundColor: Colors.grey),
          ));
        }
        if (offset != null) {
          children.add(Text(
            "!! OFFSET: ${offset.balance} !!",
            style: TextStyle(backgroundColor: Colors.purpleAccent),
          ));
        }
      } else {
        var currentTransactions = transactions.getTransactions(
            snapshot.date, DateTime.parse("2040-01-10 13:00:00"));

        for (var y = 0; y < currentTransactions.length; y++) {
          var style = (currentTransactions[y].amount > 0)
              ? TextStyle(backgroundColor: Colors.green)
              : TextStyle(backgroundColor: Colors.red);

          children.add(Text(
            currentTransactions[y].toString(),
            style: style,
          ));
          balance += currentTransactions[y].amount;
          children.add(Text(
            ShadowAccountBalance(balance, currentTransactions[y].date)
                .toString(),
            style: TextStyle(backgroundColor: Colors.grey),
          ));
        }
      }
    }

    children.add(Container(
      padding: const EdgeInsets.all(3),
      color: Colors.grey[600],
      alignment: Alignment.center,
      child: Text('Current Balance: $balance €',
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.white)),
    ));

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Transaction List'),
      ),
      child: ListView(
        children: children,
      ),
    );
  }
}
}