import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/campaign_model.dart';
import '../services/campaign_service.dart';

final campaignProvider =
    FutureProvider.family<List<Tournament>, int>((ref, campaignId) async {
  final campaignService = CampaignService();
  return await campaignService.getCampaign(campaignId);
});
