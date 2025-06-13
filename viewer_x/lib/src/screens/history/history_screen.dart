import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/src/core/extensions/context_x.dart';
import 'package:viewer_x/src/screens/history/components/history_chart.dart';
import 'package:viewer_x/src/screens/history/components/totals_card.dart';

const screenPadding = 16.0;

List<Map<String, dynamic>> totals = [
  {"type": "Recharge", "amount": 12750, "color": Colors.green},
  {"type": "Retrait", "amount": 12750, "color": Colors.red},
  {"type": "Transfert", "amount": 100, "color": Colors.blue},
];

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 40.h),
        children: [
          _buildAppBar(context),
          24.verticalSpace,
          _buildTotals(),
          32.verticalSpace,
          HistoryChart(screenPadding: screenPadding),
        ],
      ),
    );
  }

  SingleChildScrollView _buildTotals() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final total in totals) TotalsCard(total: total),
          screenPadding.horizontalSpace,
        ],
      ),
    );
  }

  Padding _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenPadding.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Historique",
            style: context.tt.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: context.cs.secondary,
              foregroundColor: context.cs.onSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
      ),
    );
  }
}
