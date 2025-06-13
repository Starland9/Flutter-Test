import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/src/core/extensions/context_x.dart';

const Map<String, int> monthsAmounts = {
  "": 0,
  "Jul": 300,
  "Aug": 100,
  "Sep": 500,
  "Oct": 700,
  "Nov": 150,
  "Dec": 500,
  "Jan": 400,
};

class HistoryChart extends StatelessWidget {
  const HistoryChart({super.key, required this.screenPadding});

  final double screenPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenPadding.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Historique des soldes en FCFA",
            style: context.tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          8.verticalSpace,
          Container(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: 32.h,
              bottom: 16.h,
            ),
            decoration: BoxDecoration(
              color: context.cs.secondary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            width: double.maxFinite,
            height: 223.h,
            child: LineChart(
              LineChartData(
                gridData: _buildGridData(context),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22.h,
                      getTitlesWidget: (value, meta) => Text(
                        monthsAmounts.keys.elementAtOrNull(value.toInt()) ?? "",
                        style: context.tt.bodySmall,
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32.w,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: context.tt.bodySmall,
                      ),
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [_buildLineData(context)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlGridData _buildGridData(BuildContext context) {
    return FlGridData(
      show: true,
      drawVerticalLine: true,
      drawHorizontalLine: true,
      getDrawingHorizontalLine: (value) {
        if (value == 0) {
          return FlLine(
            color: context.cs.onSecondary,
            strokeWidth: .5.w,
            dashArray: [5, 5],
          );
        }
        return FlLine(
          color: context.cs.onSecondary.withValues(alpha: 0.2),
          strokeWidth: .5.w,
          dashArray: [5, 5],
        );
      },
      getDrawingVerticalLine: (value) {
        if (value == 0) {
          return FlLine(
            color: context.cs.onSecondary,
            strokeWidth: .5.w,
            dashArray: [5, 5],
          );
        }
        return FlLine(
          color: context.cs.onSecondary.withValues(alpha: 0.2),
          strokeWidth: .5.w,
          dashArray: [5, 5],
        );
      },
    );
  }

  LineChartBarData _buildLineData(BuildContext context) {
    return LineChartBarData(
      preventCurveOverShooting: true,
      spots: monthsAmounts.entries
          .map(
            (e) => FlSpot(
              monthsAmounts.keys.toList().indexOf(e.key) + 1,
              e.value.toDouble(),
            ),
          )
          .toList(),
      isCurved: true,
      color: context.cs.primary,
      barWidth: 3.sp,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [context.cs.primary, context.cs.primary.withValues(alpha: 0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
