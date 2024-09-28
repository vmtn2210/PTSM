import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/models/user_profile_model.dart';
import 'package:pickle_ball/services/profile_service.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<UserProfile>> {
  final ProfileService _profileService;
  final String userId;

  ProfileNotifier(this._profileService, this.userId)
      : super(const AsyncValue.loading()) {
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    state = const AsyncValue.loading();
    try {
      final userProfile =
          await _profileService.getUserProfile(int.parse(userId));
      state = AsyncValue.data(userProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _profileService.resetPassword(email);
    } catch (e) {
      throw Exception('Failed to reset password: ${e.toString()}');
    }
  }
}

final profileProvider = StateNotifierProvider.family<ProfileNotifier,
    AsyncValue<UserProfile>, String>((ref, userId) {
  return ProfileNotifier(ProfileService(), userId);
});
