import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/providers/find_tournament_provider.dart';
import 'package:pickle_ball/views/find_tournament/widgets/item_find_tourament_widget.dart';

import '../../common/widgets/search_form_field.dart';

class FindTournamentView extends ConsumerStatefulWidget {
  const FindTournamentView({super.key});

  @override
  ConsumerState<FindTournamentView> createState() => _FindTournamentViewState();
}

class _FindTournamentViewState extends ConsumerState<FindTournamentView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(findTournamentProvider.notifier).fetchTournaments());
  }

  @override
  Widget build(BuildContext context) {
    final findTournamentState = ref.watch(findTournamentProvider);

    return Scaffold(
      backgroundColor: ColorUtils.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Find Tournament',
          style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20).r,
        child: Column(
          children: [
            SearchFormField(
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  AssetUtils.search,
                ),
              ),
              onChanged: (query) {
                ref
                    .read(findTournamentProvider.notifier)
                    .searchTournaments(query);
              },
            ),
            Expanded(
              child: findTournamentState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: findTournamentState.tournaments.length,
                      itemBuilder: (context, index) {
                        final tournament =
                            findTournamentState.tournaments[index];
                        return ItemFindTournamentWidget(tournament: tournament);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
