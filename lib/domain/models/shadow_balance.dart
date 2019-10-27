import 'package:hunger_preventer/domain/models/balance_snapshot.dart';

class ShadowAccountBalance extends AccountBalanceSnapshot {
  ShadowAccountBalance(int balance, DateTime date) : super(balance, date);

  @override
  String toString() {
    return '${this.date.day}/${this.date.month}/${this.date.year} ${this.balance} Shadow Account Balance';
  }
}