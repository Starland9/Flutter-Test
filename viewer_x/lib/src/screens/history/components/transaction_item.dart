import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/src/core/extensions/context_x.dart';
import 'package:viewer_x/src/core/extensions/date_x.dart';
import 'package:viewer_x/src/core/extensions/string_x.dart';
import 'package:viewer_x/src/core/extensions/transaction_x.dart';
import 'package:viewer_x/src/logic/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Row(
        spacing: 10.w,
        children: [
          _buildIcon(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildTitle(context), _buildSubtitle(context)],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${transaction.amountString} / ${transaction.fee.toString().amountize()} Fcfa",
                style: context.tt.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: transaction.color,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${transaction.date.formatted}, ",
                      style: context.tt.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    TextSpan(
                      text: transaction.statusText(context),
                      style: context.tt.bodySmall?.copyWith(
                        color: transaction.statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text _buildSubtitle(BuildContext context) {
    return Text(
      transaction.from,
      style: context.tt.bodySmall?.copyWith(color: Colors.grey.shade700),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      transaction.title,
      style: context.tt.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Container _buildIcon(BuildContext context) {
    return Container(
      width: 60.sp,
      height: 60.sp,
      decoration: BoxDecoration(
        color: context.cs.secondary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(
        transaction.transactionType == TransactionType.deposit
            ? CupertinoIcons.arrow_up
            : CupertinoIcons.arrow_down,
        color: transaction.color,
      ),
    );
  }
}
