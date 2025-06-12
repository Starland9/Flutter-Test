import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/gen/assets.gen.dart';
import 'package:viewer_x/src/core/extensions/context_x.dart';
import 'package:viewer_x/src/core/themes/colors/app_colors.dart';
import 'package:viewer_x/src/shared/widgets/dashed_line.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Assets.images.ticket.image(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 100.h),
            child: Column(
              spacing: 8.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _unknwownCard(context),
                _buildHead(context),
                _buildDashedLine(context),
                _buildBody(context),
                _buildActions(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildActions(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => context.pop(),
              child: Text("Quitter"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: context.cs.primary,
                side: BorderSide(color: context.cs.primary, width: 1.w),
              ),
              onPressed: () {},
              child: Text("Transférer de nouveau"),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(16.w),
      width: double.maxFinite,
      height: 281.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.ticketFg.withValues(alpha: 0.5),
          width: .7.w,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Source",
            style: context.tt.bodySmall?.copyWith(color: AppColors.ticketFg),
          ),
          4.verticalSpace,
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: AppColors.ticketFg,
              radius: 24.r,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mastercard",
                  style: context.tt.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                8.verticalSpace,
                Text(
                  "Débit* 1234",
                  style: context.tt.bodySmall?.copyWith(
                    color: AppColors.ticketFg,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.ticketFg.withValues(alpha: .5),
            height: 32.h,
          ),
          Text(
            "Resumé de paiement",
            style: context.tt.bodySmall?.copyWith(color: AppColors.ticketFg),
          ),
          8.verticalSpace,
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.w),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.ticketFg.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _amoutTile(context, title: "Montant", value: "10.000"),
                  _amoutTile(
                    context,
                    title: "Frais de transfert",
                    value: "100",
                  ),
                  _amoutTile(
                    context,
                    title: "Total",
                    value: "10.100",
                    leadingTextStyle: TextStyle(),
                    trailingTextStyle: context.tt.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: context.cs.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _amoutTile(
    BuildContext context, {
    required String title,
    required String value,
    TextStyle? leadingTextStyle,
    TextStyle? trailingTextStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              leadingTextStyle ??
              context.tt.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.ticketFg,
              ),
        ),

        Text(
          "$value FCFA",
          style: trailingTextStyle ?? TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Padding _buildDashedLine(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 9.h),
      child: DashedLine(
        width: double.maxFinite,
        height: 10.h,
        dashWidth: 8.w,
        dashSpace: 8.w,
        color: context.cs.primary,
      ),
    );
  }

  Column _buildHead(BuildContext context) {
    return Column(
      spacing: 8.h,
      children: [
        Text(
          "Bae",
          style: context.tt.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Transféré le 02 Février 2025",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        Chip(
          side: BorderSide.none,
          label: RichText(
            text: TextSpan(
              style: context.tt.bodyMedium?.copyWith(),
              children: [
                TextSpan(text: "Etat des transactions: "),
                TextSpan(
                  text: "Payé",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Card _unknwownCard(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Container(color: context.cs.primary, width: 120.w, height: 56.h),
    );
  }
}
