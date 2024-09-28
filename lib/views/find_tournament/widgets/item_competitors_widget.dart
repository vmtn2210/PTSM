import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/models/athletes_model.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';

class ItemCompetitorsWidget extends StatelessWidget {
  final Athlete athlete;

  const ItemCompetitorsWidget({
    super.key,
    required this.athlete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensure the container has a width
      height: 200.h, // Set a fixed height or adjust as needed
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorUtils.grayColor.withOpacity(.3),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            AssetUtils.imgSignIn,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AssetUtils.imgSignIn,
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.blue.shade900.withOpacity(1),
                    Colors.blue.shade500.withOpacity(0.1),
                  ],
                ),
              ),
              padding: EdgeInsets.all(8.w),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Use minimum vertical space
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    athlete.athleteName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Rank: ${athlete.rank}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    'Gender: ${athlete.gender}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    'Type: ${athlete.athleteType}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
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
}
