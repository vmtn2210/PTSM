import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/campaign_registration_service.dart';

final campaignRegistrationProvider =
    Provider((ref) => CampaignRegistrationService());

final campaignRegistrationStateProvider =
    StateProvider<AsyncValue<bool>>((ref) => const AsyncValue.data(false));
