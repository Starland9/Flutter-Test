import 'package:viewer_x/src/core/extensions/string_x.dart';

enum TransactionType { deposit, redraw, transfert, unknown }

enum TransactionStatus { success, pending, failed, unknown }

class Transaction {
  final String title;
  final double amount;
  final String from;
  final int fee;
  final DateTime date;
  final String type;
  final String status;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.status,
    required this.from,
    this.fee = 0,
  });

  TransactionType get transactionType {
    return switch (type) {
      "Recharge" => TransactionType.deposit,
      "Retrait" => TransactionType.redraw,
      "Transfert" => TransactionType.transfert,
      _ => TransactionType.unknown,
    };
  }

  TransactionStatus get transactionStatus {
    return switch (status) {
      "success" => TransactionStatus.success,
      "pending" => TransactionStatus.pending,
      "failed" => TransactionStatus.failed,
      _ => TransactionStatus.unknown,
    };
  }

  String get amountString {
    String sign = "+";

    if (transactionType == TransactionType.redraw) {
      sign = "-";
    }

    return "$sign${amount.toInt().toString().amountize()}";
  }
}
