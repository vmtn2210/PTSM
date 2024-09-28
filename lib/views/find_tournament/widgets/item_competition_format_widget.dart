import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/models/campaign_model.dart';
import 'package:pickle_ball/views/find_tournament/views/group_stage_view.dart';
import 'package:pickle_ball/views/find_tournament/views/tournament_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/providers/auth_provider.dart';
import 'package:pickle_ball/providers/tournament_registration_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemCompetitionFormatWidget extends ConsumerWidget {
  final Tournament tournament;

  const ItemCompetitionFormatWidget({
    super.key,
    required this.tournament,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isAdmin = authState.isAuthenticated &&
        authState.userId != null &&
        authState.userId == '1';

    return GestureDetector(
      onTap: () {
        if (tournament.tournamentType == 'Elimination') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TournamentView(tournamentId: tournament.tournamentId ?? 0)),
          );
        } else if (tournament.tournamentType == 'GroupStage') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    GroupStageView(tournamentId: tournament.tournamentId ?? 0)),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: ColorUtils.grayColor.withOpacity(.3),
              blurRadius: 3,
              spreadRadius: 3,
            ),
          ],
        ),
        child: SizedBox(
          width: 130.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  tournament.imageUrl ?? AssetUtils.imgSignIn,
                  height: 130.h,
                  width: 130.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AssetUtils.imgSignIn,
                      height: 130.h,
                      width: 130.w,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                tournament.tournamentName ?? 'Unnamed Tournament',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                '${tournament.formatType ?? 'N/A'} | ${tournament.tournamentType ?? 'N/A'} | Rank ${tournament.rank ?? 'N/A'}',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 8),
              if (!isAdmin)
                ElevatedButton(
                  onPressed: () => _showRegistrationDialog(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[100],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Register', style: TextStyle(fontSize: 12)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRegistrationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Registration'),
          content: const Text('Do you want to register for this tournament?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Register'),
              onPressed: () {
                Navigator.of(context).pop();
                _registerForTournament(context, ref);
              },
            ),
          ],
        );
      },
    );
  }

  void _registerForTournament(BuildContext context, WidgetRef ref) async {
    final registrationService = ref.read(tournamentRegistrationProvider);
    final registrationState =
        ref.read(tournamentRegistrationStateProvider.notifier);

    registrationState.state = const AsyncValue.loading();

    try {
      final result = await registrationService
          .registerForTournament(tournament.tournamentId ?? 0);
      if (result) {
        registrationState.state = const AsyncValue.data(true);
        Fluttertoast.showToast(
            msg: "Registration successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        registrationState.state = const AsyncValue.data(false);
        Fluttertoast.showToast(
            msg: "You have already registered for this tournament",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      registrationState.state = AsyncValue.error(e, StackTrace.current);
      Fluttertoast.showToast(
          msg: "Error: ${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
