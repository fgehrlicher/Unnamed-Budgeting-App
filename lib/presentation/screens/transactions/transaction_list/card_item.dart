import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction.dart';

class CardItem extends StatelessWidget {
  final Transaction _transaction;
  final VoidCallback _onTap;

  const CardItem(
    this._transaction,
    this._onTap,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Card(
          child: ListTile(
            leading: Container(
              color: _transaction.category?.color ?? Colors.grey,
              width: 50,
              height: 50,
              child: _transaction.category != null
                  ? Icon(
                      _transaction.category?.icon?.iconData,
                      size: 30,
                    )
                  : Container(
                      height: 30,
                      width: 30,
                    ),
            ),
            title: Text(
              _transaction.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            isThreeLine: true,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _transaction.formattedBalance,
                  style: TextStyle(
                    color: _transaction.amount > 0 ? Colors.green : Colors.red,
                    fontSize: 15,
                  ),
                ),
                Text(
                  _transaction.formattedDate,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            onTap: _onTap,
          ),
        ),
      ),
    );
  }
}
