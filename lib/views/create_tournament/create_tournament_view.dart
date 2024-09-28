import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/common/widgets/text_form_field.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/views/create_tournament/widgets/add_image_form_field_widget.dart';
import 'package:pickle_ball/views/create_tournament/widgets/choice_widget.dart';

import '../../common/widgets/text_button_widget.dart';

class CreateTournamentView extends ConsumerWidget {
  const CreateTournamentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    return Scaffold(
      backgroundColor: ColorUtils.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Create Tournament',
          style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                  'Please fulfill properly data for all required field!'),
              const SizedBox(
                height: 10,
              ),
              const CarImageTextFormFieldWidget(),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldCustomWidget(
                controller: nameController,
                hint: 'Name',
                label: 'Name',
                requiedText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldCustomWidget(
                controller: nameController,
                hint: 'Location',
                label: 'Location',
                requiedText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldCustomWidget(
                controller: nameController,
                hint: 'dd/mm/yyyy',
                label: 'Start Date',
                requiedText: true,
                suffixIcon: const Icon(Icons.calendar_month),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldCustomWidget(
                controller: nameController,
                hint: 'dd/mm/yyyy',
                label: 'End Date',
                requiedText: true,
                suffixIcon: const Icon(Icons.calendar_month),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldCustomWidget(
                controller: nameController,
                hint: 'Enter a description...',
                label: 'Description',
                maxLine: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              const ChoiceWidget(),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldCustomWidget(
                controller: nameController,
                hint: 'Number',
                label: 'Number of Competitors',
                requiedText: true,
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButtonWidget(
                label: 'Create',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
