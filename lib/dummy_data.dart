import 'package:faker/faker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unnamed_budgeting_app/data/database/database_provider.dart';
import 'package:unnamed_budgeting_app/data/repository/account_balance_repository.dart';
import 'package:unnamed_budgeting_app/data/repository/transaction_category_repository.dart';
import 'package:unnamed_budgeting_app/data/repository/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/model/acount_balance.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction.dart' as model;
import 'package:unnamed_budgeting_app/domain/model/transaction_category.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction_list.dart';
import 'dart:math';

class DummyData {
  void insertDummyData() {
    var database = DatabaseProvider.database;
    var random = Random();
    var transactionRepository = TransactionRepository(database:  database);
    var accountBalanceRepository = AccountBalanceRepository(database: database);
    var transactionCategoryRepository = TransactionCategoryRepository(database: database);
    var dummyTransactions = List<model.Transaction>.generate(
      200,
      (int index) => model.Transaction(
        title: faker.lorem.words(3).join(" "),
        category: initialTransactionCategories[
            random.nextInt(initialTransactionCategories.length)],
        date: DateTime.parse(
            "2019-12-${random.nextInt(20) + 10} ${random.nextInt(13) + 10}:${random.nextInt(49) + 10}:${random.nextInt(49) + 10}"),
        amount: random.nextInt(600000) - 300000,
      ),
    );

    database.then((Database database) {
      var tableName = model.Transaction.TABLE_NAME;
      database.rawQuery("Delete from $tableName;");
      database.rawQuery(
        "DELETE FROM SQLITE_SEQUENCE WHERE name='$tableName';",
      );
    });

    transactionRepository.insertMultiple(
      TransactionList()..addAll(dummyTransactions),
    );

    List<AccountBalance> accountBalances = [
      AccountBalance(
        id: 1,
        date: DateTime.parse("2019-12-10 10:00:00"),
        balance: 10200,
      ),
      AccountBalance(
        id: 1,
        date: DateTime.parse("2019-12-15 10:00:00"),
        balance: 11200,
      ),
      AccountBalance(
        id: 1,
        date: DateTime.parse("2019-12-20 10:00:00"),
        balance: 21200,
      ),
      AccountBalance(
        id: 1,
        date: DateTime.parse("2019-12-30 10:00:00"),
        balance: 11200,
      ),
    ];

    accountBalanceRepository.insertMultiple(accountBalances);

    transactionCategoryRepository.insertMultiple(initialTransactionCategories);
  }
}
