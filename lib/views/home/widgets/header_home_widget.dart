import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetUtils.imgSignUp),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding:
            const EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 20).r,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 4, 39, 68).withOpacity(0.7),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'PICKLE ',
                          style: TextStyle(
                            color: ColorUtils.greenColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'BALL',
                          style: TextStyle(
                            color: ColorUtils.whiteColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'CLUB',
                      style: TextStyle(
                        color: ColorUtils.whiteColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 120.w,
                      child: Text(
                        'How do you create compelling presentations that wow your colleagues and impress your managers? Find out with our in-depth guide on UX presentations.',
                        style: TextStyle(
                          color: ColorUtils.whiteColor,
                          fontSize: 8.sp,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: null,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 20.h,
                ),
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow,
                        offset: Offset(4, 4),
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    AssetUtils.imgHome,
                    height: 140.h,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }
}
