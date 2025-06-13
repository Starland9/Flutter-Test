import 'package:flutter/material.dart';
import 'package:viewer_x/src/logic/models/transaction.dart';

extension TransactionX on Transaction {
  Color get color {
    return switch (transactionType) {
      TransactionType.deposit => Colors.green,
      TransactionType.redraw => Colors.red,
      TransactionType.transfert => Colors.blue,
      _ => Colors.black,
    };
  }

  Color get statusColor {
    return switch (transactionStatus) {
      TransactionStatus.success => Colors.green,
      TransactionStatus.pending => Colors.yellow,
      TransactionStatus.failed => Colors.red,
      _ => Colors.black,
    };
  }

  String statusText(BuildContext context) {
    return switch (transactionStatus) {
      TransactionStatus.success => "Succès",
      TransactionStatus.pending => "En cours",
      TransactionStatus.failed => "En echec",
      _ => "Inconnu",
    };
  }
}
