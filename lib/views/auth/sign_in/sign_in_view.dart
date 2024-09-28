import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/common/widgets/text_form_field_auth.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import '../../../common/widgets/text_button_widget.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final TextEditingController usernameController =
      TextEditingController(text: 'SystemManager');
  final TextEditingController passwordController =
      TextEditingController(text: '@@abc123@@');
  bool _obscureText = true;

  void _showMessage(String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _login() async {
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.login(
      usernameController.text,
      passwordController.text,
    );

    final authState = ref.read(authProvider);
    if (authState.isAuthenticated) {
      _showMessage('Login successful', false);
      if (mounted) {
        Routes.goToBottomNavigatorScreen(context);
      }
    } else if (authState.error != null) {
      _showMessage('Login failed: ${authState.error}', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetUtils.imgSignIn),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: ScreenUtil().screenHeight,
            padding:
                const EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 20)
                    .r,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AssetUtils.imgHeader,
                  height: 70.h,
                ),
                SizedBox(
                  height: 40.h,
                ),
                TextFormFieldAuthWidget(
                  hint: 'Username',
                  label: "Username",
                  inputAction: TextInputAction.next,
                  controller: usernameController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormFieldAuthWidget(
                  hint: 'Your password',
                  label: "Password",
                  controller: passwordController,
                  inputAction: TextInputAction.done,
                  obscureText: _obscureText,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextButtonWidget(
                  label: authState.isLoading ? 'Logging in...' : 'Login',
                  onPressed: authState.isLoading ? null : _login,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: ColorUtils.textColor,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Routes.goToSignUpScreen(context),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: ColorUtils.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
