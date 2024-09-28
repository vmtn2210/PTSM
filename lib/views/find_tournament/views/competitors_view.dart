import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/providers/athletes_provider.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/views/find_tournament/widgets/item_competitors_widget.dart';

class CompetitorsView extends ConsumerWidget {
  final int campaignId;

  const CompetitorsView({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final athletesAsyncValue = ref.watch(athletesProvider(campaignId));

    return Scaffold(
      backgroundColor: ColorUtils.primaryBackgroundColor,
      body: athletesAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('Chưa có người tham gia')),
        data: (athletes) {
          return Padding(
            padding: EdgeInsets.all(10.w),
            child: ListView.builder(
              itemCount: athletes.length,
              itemBuilder: (context, index) {
                final athlete = athletes[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: ItemCompetitorsWidget(athlete: athlete),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
