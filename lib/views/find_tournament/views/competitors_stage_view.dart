import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/providers/athletes_provider.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/views/find_tournament/widgets/item_competitors_widget.dart';

class CompetitorsStageView extends ConsumerWidget {
  final int tournamentId;

  const CompetitorsStageView({super.key, required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final athletesAsyncValue = ref.watch(athleteByIdProvider(tournamentId));

    return Container(
      color: ColorUtils.primaryBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Competitors',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            const SizedBox(height: 10),
            athletesAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  const Center(child: Text('Chưa có người tham gia')),
              data: (athletes) {
                if (athletes.isEmpty) {
                  return const Center(child: Text('No competitors available'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemCount: athletes.length,
                  itemBuilder: (context, index) {
                    final athlete = athletes[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: ItemCompetitorsWidget(athlete: athlete),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
