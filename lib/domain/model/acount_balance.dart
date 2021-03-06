import 'package:unnamed_budgeting_app/data/database/field_config.dart';
import 'package:unnamed_budgeting_app/data/database/persistent_model.dart';
import 'package:unnamed_budgeting_app/data/database/sqlite_types.dart';

class AccountBalance implements PersistentModel {
  static const String TABLE_NAME = "accountbalance";

  int id;
  static const String ID_NAME = "id";
  static const String ID_CONFIG = SqliteTypes.PRIMARY_KEY;

  DateTime date;
  static const String DATE_NAME = "date";
  static const String DATE_CONFIG = SqliteTypes.INT + SqliteTypes.NOT_NULL;

  int balance;
  static const String BALANCE_NAME = "balance";
  static const String BALANCE_CONFIG = SqliteTypes.INT + SqliteTypes.NOT_NULL;

  AccountBalance({this.id, this.date, this.balance});

  AccountBalance.fromMap(Map<String, dynamic> data) {
    id = data[ID_NAME];
    balance = data[BALANCE_NAME];
    date = DateTime.fromMillisecondsSinceEpoch(data[DATE_NAME]);
  }

  @override
  String get tableName {
    return TABLE_NAME;
  }

  @override
  String get idFieldName {
    return ID_NAME;
  }

  @override
  int get idField {
    return id;
  }

  @override
  List<FieldConfig> get fieldConf {
    return [
      FieldConfig(ID_NAME, ID_CONFIG),
      FieldConfig(DATE_NAME, DATE_CONFIG),
      FieldConfig(BALANCE_NAME, BALANCE_CONFIG),
    ];
  }

  String get formattedBalance {
    var minimalLength = 3;
    var postDecimalPointChars = 2;

    var rawBalance = balance != null ? balance.toString() : "";
    rawBalance = rawBalance.padLeft(minimalLength, "0");
    var balanceLength = rawBalance.length;

    var preDecimalPoint =
    rawBalance.substring(0, balanceLength - postDecimalPointChars);
    var postDecimalPoint =
    rawBalance.substring(balanceLength - postDecimalPointChars);

    return "$preDecimalPoint.$postDecimalPoint \€";
  }

  Map<String, dynamic> toMap() {
    var map = {
      ID_NAME: id,
      DATE_NAME: date.millisecondsSinceEpoch,
      BALANCE_NAME: balance
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

}
