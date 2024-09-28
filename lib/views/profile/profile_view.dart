import 'package:flutter/material.dart';
import 'package:pickle_ball/services/auth_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/utils/routes/routes.dart';
import 'package:pickle_ball/views/profile/widgets/button_settings_widget.dart';
import 'package:pickle_ball/views/profile/views/profile_detail_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/providers/profile_provider.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final authService = AuthService();
    userId = await authService.getUserId();
    if (userId != null) {
      setState(() {}); // Trigger a rebuild to use the userId
    }
  }

  Future<void> _showResetPasswordDialog(String email) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to reset the password for $email?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetPassword(email);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetPassword(String email) async {
    try {
      await ref.read(profileProvider(userId!).notifier).resetPassword(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync =
        userId != null ? ref.watch(profileProvider(userId!)) : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Profile',
          style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: profileAsync == null
          ? const Center(child: CircularProgressIndicator())
          : profileAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
              data: (userProfile) => SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    children: [
                      Container(
                        width: ScreenUtil().screenWidth,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage(AssetUtils.imgSignIn),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              maxRadius: 40,
                              backgroundColor: Colors.white,
                              backgroundImage: userProfile.imageUrl != null &&
                                      userProfile.imageUrl!.isNotEmpty
                                  ? NetworkImage(userProfile.imageUrl!)
                                  : null,
                              child: userProfile.imageUrl == null ||
                                      userProfile.imageUrl!.isEmpty
                                  ? SvgPicture.asset(
                                      'assets/icons/ic_user_account.svg',
                                      color: ColorUtils.greenColor,
                                      height: 40,
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 10),
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  colors: [Colors.yellow, Colors.red],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 500),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 8.0,
                                      color: Colors.black.withOpacity(0.7),
                                      offset: const Offset(3.0, 3.0),
                                    ),
                                    Shadow(
                                      blurRadius: 8.0,
                                      color: Colors.white.withOpacity(0.7),
                                      offset: const Offset(-2.0, -2.0),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  userProfile.fullName ?? "Unknown",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              userProfile.email ?? "No email",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorUtils.whiteColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      ButtonSettingsWidget(
                        icon: SvgPicture.asset(
                          AssetUtils.icUser,
                          color: Colors.black,
                        ),
                        title: 'Profile Detail',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileDetailView(),
                            ),
                          );
                        },
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: ColorUtils.blueColor,
                      ),
                      ButtonSettingsWidget(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        title: 'Reset Password',
                        onPressed: () {
                          _showResetPasswordDialog(userProfile.email ?? '');
                        },
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: ColorUtils.blueColor,
                      ),
                      ButtonSettingsWidget(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        title: 'Logout',
                        onPressed: () => Routes.goToSignInScreen(context),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: ColorUtils.textColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
