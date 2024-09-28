import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/models/pickleball_match_model.dart';
import 'package:intl/intl.dart';

class ItemScheduleWidget extends StatelessWidget {
  final PickleballMatch match;

  const ItemScheduleWidget({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorUtils.grayColor.withOpacity(.3),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('HH').format(match.matchDate),
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorUtils.greenColor,
                  fontSize: 30,
                ),
              ),
              Text(
                DateFormat('mm').format(match.matchDate),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorUtils.primaryColor,
                  fontSize: 25,
                ),
              )
            ],
          ),
          Text(DateFormat('EEEE, dd/MM').format(match.matchDate)),
          const SizedBox(height: 10),
          Text(
            'Round ${match.roundOrder}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorUtils.primaryColor,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  match.firstTeam ?? 'Team 1',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.asset(
                  AssetUtils.imgSignIn,
                  height: 50.h,
                  width: 50.w,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "vs",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.greenColor,
                    fontSize: 20,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.asset(
                  AssetUtils.imgSignIn,
                  height: 50.h,
                  width: 50.w,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Text(
                  match.secondTeam ?? 'Team 2',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Court: ${match.court ?? 'TBA'}',
            style: TextStyle(
              color: ColorUtils.primaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
