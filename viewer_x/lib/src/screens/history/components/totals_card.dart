import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/src/core/extensions/context_x.dart';
import 'package:viewer_x/src/core/extensions/string_x.dart';
import 'package:viewer_x/src/screens/history/history_screen.dart';

class TotalsCard extends StatelessWidget {
  const TotalsCard({super.key, required this.total});

  final Map<String, dynamic> total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 77.h,
      margin: EdgeInsets.only(left: screenPadding.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.cs.secondary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_buildIcon(), _builtDetails(context)],
      ),
    );
  }

  Column _builtDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              total["amount"].toString().amountize(),
              style: context.tt.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: total["color"],
              ),
            ),
            Text(
              "Fcfa",
              style: context.tt.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: total["color"],
              ),
            ),
          ],
        ),
        Text(
          total["type"],
          style: context.tt.bodySmall?.copyWith(color: Colors.grey.shade700),
        ),
      ],
    );
  }

  Container _buildIcon() {
    return Container(
      width: 45.w,
      height: 45.w,
      decoration: BoxDecoration(
        color: (total["color"] as Color).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(
        total["color"] == Colors.green
            ? CupertinoIcons.arrow_up
            : CupertinoIcons.arrow_down,
        color: total["color"],
        size: 20.sp,
      ),
    );
  }
}
