import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';

class FooterHomeWidget extends StatelessWidget {
  const FooterHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetUtils.imgSignIn),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20).r,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 4, 39, 68).withOpacity(0.7),
        ),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Share With Friends',
                  style: TextStyle(
                    color: ColorUtils.whiteColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Share your tournaments all over the internet tubes like a real magician! Easily post your comments in a league dashboard and discuss with other followers.',
                  style: TextStyle(
                    color: ColorUtils.whiteColor,
                    fontSize: 8.sp,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  maxLines: null,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
