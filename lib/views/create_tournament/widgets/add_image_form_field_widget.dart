import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/utils/popup_utils.dart';

class CarImageTextFormFieldWidget extends StatelessWidget {
  const CarImageTextFormFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Tournament Logo',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async => PopupUtils.showBottomSheetAddImageDialog(
            context: context,
            onSelectPressedCamera: () {},
            onSelectPressedGallery: () {},
          ),
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: ColorUtils.greenColor),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
