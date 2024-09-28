import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/utils/color_utils.dart';

class BodyHomeWidget extends StatelessWidget {
  const BodyHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Run Tournament',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'There are 3 important periods to run your tournaments',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: ColorUtils.greenColor,
                child: Icon(
                  Icons.list,
                  color: ColorUtils.primaryColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Create a Tournament',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  checkListWidget('Elimination')
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: ColorUtils.greenColor,
                child: Icon(
                  Icons.settings_outlined,
                  color: ColorUtils.primaryColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Setting a Tournament',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  checkListWidget('Input Rules, location'),
                  checkListWidget('Input teams/players information'),
                  checkListWidget('Invite participants'),
                  checkListWidget('Set calendar for matches'),
                  checkListWidget('Customize for each stage'),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: ColorUtils.greenColor,
                child: Icon(
                  Icons.check_box_outlined,
                  color: ColorUtils.primaryColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Run Tournament',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  checkListWidget('Activate'),
                  checkListWidget('Enter results'),
                  checkListWidget('View statistics'),
                  checkListWidget('Share with friends'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget checkListWidget(String subTitle) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        const Icon(
          Icons.check,
          color: Colors.green,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ],
    ),
  );
}
