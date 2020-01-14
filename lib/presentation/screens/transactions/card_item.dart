import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart';

class CardItem extends StatelessWidget {
  final Transaction _transaction;
  final VoidCallback _onTap;
  final Animation<double> animation;

  const CardItem(
    this._transaction,
    this._onTap,
    this.animation,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _onTap,
          child: Card(
            child: ListTile(
              leading: _transaction.category != null
                  ? Icon(
                      _transaction.category.iconData,
                      size: 30,
                    )
                  : Container(
                      height: 30,
                      width: 30,
                    ),
              title: Text(
                _transaction.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _transaction.getFormattedBalance(),
                style: TextStyle(
                  color: _transaction.amount > 0 ? Colors.green : Colors.red,
                  fontSize: 15,
                ),
              ),
              onTap: _onTap,
            ),
          ),
        ),
      ),
    );
  }
}