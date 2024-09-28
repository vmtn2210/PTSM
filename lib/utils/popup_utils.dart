import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickle_ball/common/widgets/text_button_outline_widget.dart';
import 'package:pickle_ball/common/widgets/text_button_widget.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';

class PopupUtils {
  PopupUtils._();

  static void showPopup(
    BuildContext context, {
    required String icon,
    required String title,
    String? message,
    Widget? action,
    String? messageBetween,
    VoidCallback? onTap,
    bool outsideClose = true,
  }) {
    showDialog(
      barrierDismissible: outsideClose,
      context: context,
      builder: (_) {
        return GestureDetector(
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(24.r),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 48.w,
                    height: 48.h,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: ColorUtils.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(
                    color: ColorUtils.textColor,
                    height: 36.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50.h,
                          child: TextButtonWidget(
                            onPressed: onTap,
                            label: "Delete",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50.h,
                          child: TextButtonOutlineWidget(
                            onPressed: () => Navigator.pop(context),
                            label: "Cancel",
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showBottomSheetDialog({
    required BuildContext context,
    required Widget dialog,
  }) {
    return showModalBottomSheet(
      backgroundColor: ColorUtils.whiteColor,
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: dialog),
        );
      },
    );
  }

  static Future<void> showBottomSheetAddImageDialog({
    required BuildContext context,
    VoidCallback? onSelectPressedCamera,
    VoidCallback? onSelectPressedGallery,
  }) {
    return showModalBottomSheet(
      backgroundColor: ColorUtils.whiteColor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      builder: (_) {
        return Wrap(
          children: [
            Container(
              width: 414.w,
              margin: EdgeInsets.only(
                bottom: 20.h,
              ),
              child: Column(
                children: [
                  Container(
                    height: 4.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: ColorUtils.blueColor,
                      borderRadius: BorderRadius.circular(2.h),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                  SizedBox(height: 16.h),
                  buildIconOption(
                    iconName: AssetUtils.icCamera,
                    title: "Add photos from camera",
                    onPressed: () {
                      Navigator.of(context).pop();
                      onSelectPressedCamera?.call();
                    },
                  ),
                  Container(
                    height: 1.h,
                    color: ColorUtils.primaryColor,
                    margin: EdgeInsets.only(
                      left: 72.w,
                      right: 16.w,
                    ),
                  ),
                  buildIconOption(
                    iconName: AssetUtils.icGallery,
                    title: "Add photos from Gallery",
                    onPressed: () {
                      Navigator.of(context).pop();
                      onSelectPressedGallery?.call();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget buildIconOption({
  required String iconName,
  required String title,
  VoidCallback? onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 56.h,
      padding: EdgeInsets.only(
        left: 24.w,
        right: 16.w,
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 48.h,
              width: 48.h,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                iconName,
                colorFilter: ColorFilter.mode(
                  ColorUtils.primaryColor,
                  BlendMode.srcIn,
                ),
                height: 20.h,
                width: 20.w,
              )),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorUtils.primaryColor),
            ),
          ),
        ],
      ),
    ),
  );
}