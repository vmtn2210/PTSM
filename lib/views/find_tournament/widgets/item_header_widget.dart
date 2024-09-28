import 'package:flutter/material.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/models/find_tournament_model.dart';
import 'package:intl/intl.dart';

class ItemHeaderWidget extends StatelessWidget {
  final FindTournamentModel tournament;

  const ItemHeaderWidget({
    super.key,
    required this.tournament,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Image.network(
            tournament.imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AssetUtils.imgSignIn,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                tournament.tournamentName,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                tournament.locations.first.courtGroupName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Text(
                '${DateFormat('dd/MM/yyyy').format(tournament.startDate)} - ${DateFormat('dd/MM/yyyy').format(tournament.endDate)}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }
}
