import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/views/find_tournament/views/about_view.dart';
import 'package:pickle_ball/views/find_tournament/views/competition_format_view.dart';
import 'package:pickle_ball/views/find_tournament/views/competitors_view.dart';
import 'package:pickle_ball/providers/find_tournament_provider.dart';
import 'package:pickle_ball/models/find_tournament_model.dart';

class FindTournamentDetailView extends ConsumerStatefulWidget {
  final int tournamentId;

  const FindTournamentDetailView({super.key, required this.tournamentId});

  @override
  ConsumerState<FindTournamentDetailView> createState() =>
      _FindTournamentDetailViewState();
}

class _FindTournamentDetailViewState
    extends ConsumerState<FindTournamentDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.microtask(
        () => ref.read(findTournamentProvider.notifier).fetchTournaments());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final findTournamentState = ref.watch(findTournamentProvider);
    final FindTournamentModel tournament = findTournamentState.tournaments
        .firstWhere((t) => t.id == widget.tournamentId);

    return Scaffold(
      backgroundColor: ColorUtils.primaryBackgroundColor,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              image: const DecorationImage(
                image: AssetImage(AssetUtils.imgHeaderFind),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                headerWidget(context, tournament),
                TabBar(
                  dividerColor: Colors.white,
                  controller: _tabController,
                  isScrollable: true,
                  tabs: [
                    _buildTab('Competition Format'),
                    _buildTab('Competitors'),
                    // _buildTab('Tournament'),
                    // _buildTab('Schedule'),
                    _buildTab('About'),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                  ),
                  unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: _CustomTabIndicator(),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CompetitionFormatView(
                  campaignId: widget.tournamentId,
                ),
                CompetitorsView(
                  campaignId: widget.tournamentId,
                ),
                AboutView(tournamentId: widget.tournamentId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerWidget(BuildContext context, FindTournamentModel? tournament) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
            )),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Image.network(
            tournament?.imageUrl ?? AssetUtils.imgSignIn,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AssetUtils.imgSignIn,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                tournament?.tournamentName ?? 'Tournament Name',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                tournament?.locations.first.courtGroupName ?? 'Location',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    '12',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.person_2_outlined,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    '12',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTab(String text) {
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}

class _CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter();
  }
}

class _CustomPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    canvas.drawLine(
      Offset(rect.left, rect.bottom),
      Offset(rect.right, rect.bottom),
      paint,
    );

    final path = Path();
    path.moveTo(rect.center.dx - 7, rect.bottom);
    path.lineTo(rect.center.dx + 7, rect.bottom);
    path.lineTo(rect.center.dx, rect.bottom - 7);
    path.close();

    canvas.drawPath(path, paint);
  }
}
