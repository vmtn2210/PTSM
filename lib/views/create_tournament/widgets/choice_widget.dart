import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/utils/color_utils.dart';

class ChoiceWidget extends StatefulWidget {
  const ChoiceWidget({
    super.key,
  });

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  int tag = 0;

  List<String> options = [
    'Mens Single',
    'Womens Single',
    'Dual Mix',
    'Man Dual',
    'Women Dual',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Competitor Type',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) => setState(() => tag = val),
          choiceItems: C2Choice.listFrom<int, String>(
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
            tooltip: (i, v) => v,
          ),
          choiceStyle: C2ChipStyle.filled(
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(5),
            selectedStyle: C2ChipStyle(
              backgroundColor: ColorUtils.greenColor,
              borderColor: ColorUtils.greenColor,
            ),
          ),
          wrapped: true,
        ),
      ],
    );
  }
}
