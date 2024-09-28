import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/models/court_group_model.dart';
import 'package:pickle_ball/services/court_group_service.dart';

final courtGroupServiceProvider = Provider((ref) => CourtGroupService());

final courtGroupProvider = FutureProvider.family<CourtGroup, int>((ref, id) async {
  final courtGroupService = ref.read(courtGroupServiceProvider);
  return courtGroupService.getCourtGroup(id);
});
