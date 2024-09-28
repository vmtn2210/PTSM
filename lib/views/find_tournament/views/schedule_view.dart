import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/models/pickleball_match_model.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/views/find_tournament/widgets/item_schedule_widget.dart';
import 'package:pickle_ball/providers/pickleball_match_provider.dart';

class ScheduleView extends ConsumerWidget {
  final int tournamentId;
  final Function(PickleballMatch) onMatchSelected;

  const ScheduleView({
    super.key,
    required this.tournamentId,
    required this.onMatchSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesAsyncValue = ref.watch(pickleballMatchProvider(tournamentId));

    return Container(
      color: ColorUtils.primaryBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Match Schedule',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            const SizedBox(height: 10),
            matchesAsyncValue.when(
              data: (matches) {
                if (matches.isEmpty) {
                  return const Center(child: Text('No matches available'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onMatchSelected(matches[index]),
                      child: ItemScheduleWidget(match: matches[index]),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ],
        ),
      ),
    );
  }
}
