import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/src/core/extensions/context_x.dart';
import 'package:viewer_x/src/logic/models/transaction.dart';
import 'package:viewer_x/src/screens/history/components/transaction_item.dart';

const screenPadding = 16.0;

List<Transaction> transactions = [
  Transaction(
    title: "Eneo",
    from: "Bae",
    amount: 5000,
    fee: 50,
    date: DateTime.now().add(Duration(hours: -1)),
    type: "Retrait",
    status: "success",
  ),
  Transaction(
    title: "Bae",
    from: "Afriland Visa",
    amount: 5000,
    fee: 0,
    date: DateTime(2024, 06, 26),
    type: "Recharge",
    status: "success",
  ),
];

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenPadding.w),
      child: Column(
        children: [
          _buildTitle(context),
          16.verticalSpace,
          for (final transaction in transactions)
            Column(
              children: [
                TransactionItem(
                  key: ValueKey(transaction.date.toIso8601String()),
                  transaction: transaction,
                ),
                16.verticalSpace,
              ],
            ),
        ],
      ),
    );
  }

  Row _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Historique des transactions",
          style: context.tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            "Voir tout",
            style: context.tt.bodyMedium?.copyWith(
              color: context.cs.primary,
              decoration: TextDecoration.underline,
              decorationThickness: 1.5.w,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
