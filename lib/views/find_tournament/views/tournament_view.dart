import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/models/pickleball_match_model.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/views/find_tournament/views/schedule_view.dart';
import 'package:pickle_ball/views/find_tournament/widgets/item_header_tournament_widget.dart';
import 'package:pickle_ball/providers/pickleball_match_provider.dart';

class TournamentView extends ConsumerStatefulWidget {
  final int tournamentId;

  const TournamentView({super.key, required this.tournamentId});

  @override
  ConsumerState<TournamentView> createState() => _TournamentViewState();
}

class _TournamentViewState extends ConsumerState<TournamentView> {
  PickleballMatch? selectedMatch;

  void onMatchSelected(PickleballMatch match) {
    setState(() {
      selectedMatch = match;
    });
  }

  @override
  Widget build(BuildContext context) {
    final matchesAsyncValue =
        ref.watch(pickleballMatchProvider(widget.tournamentId));

    return Scaffold(
      backgroundColor: ColorUtils.primaryBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetUtils.imgTournament),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const ItemHeaderTournamentWidget(),
                const SizedBox(
                  height: 20,
                ),
                matchesAsyncValue.when(
                  data: (matches) {
                    if (matches.isNotEmpty) {
                      final matchToDisplay = selectedMatch ?? matches.first;
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.orange,
                            ),
                            child: Text(
                              matchToDisplay.winningTeam == ""
                                  ? "Đang chờ kết quả"
                                  : matchToDisplay.winningTeam,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          CustomPaint(
                            size: Size(ScreenUtil().screenWidth, 50.h),
                            painter: DoubleLinePainter(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    matchToDisplay.firstTeam,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    matchToDisplay.secondTeam,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    } else {
                      return const Text('No matches available');
                    }
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Error: $error'),
                ),
                ScheduleView(
                  tournamentId: widget.tournamentId,
                  onMatchSelected: onMatchSelected,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DoubleLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final leftStartPoint = Offset(size.width * 0.25, size.height);
    final rightStartPoint = Offset(size.width * 0.75, size.height);

    final middlePoint = Offset(size.width * 0.5, 0);

    final leftPath = Path()
      ..moveTo(leftStartPoint.dx, leftStartPoint.dy)
      ..lineTo(leftStartPoint.dx, leftStartPoint.dy - size.height * 0.5)
      ..lineTo(size.width * 0.5, leftStartPoint.dy - size.height * 0.5)
      ..lineTo(middlePoint.dx, middlePoint.dy);

    final rightPath = Path()
      ..moveTo(rightStartPoint.dx, rightStartPoint.dy)
      ..lineTo(rightStartPoint.dx, rightStartPoint.dy - size.height * 0.5)
      ..lineTo(size.width * 0.5, rightStartPoint.dy - size.height * 0.5)
      ..lineTo(middlePoint.dx, middlePoint.dy);

    canvas.drawPath(leftPath, paint);
    canvas.drawPath(rightPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
