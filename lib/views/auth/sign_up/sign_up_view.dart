import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/common/widgets/text_form_field_auth.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import '../../../common/widgets/text_button_widget.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/routes/routes.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String? selectedGender;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetUtils.imgSignUp),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                      top: 70, left: 30, right: 30, bottom: 20)
                  .r,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 4, 39, 68).withOpacity(0.7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AssetUtils.imgHeader,
                    height: 70.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: ColorUtils.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormFieldAuthWidget(
                    hint: 'Your full name',
                    label: "Full Name",
                    controller: fullNameController,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormFieldAuthWidget(
                    hint: 'Your date of birth',
                    label: "Date of Birth",
                    controller: dateOfBirthController,
                    inputAction: TextInputAction.next,
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            dateOfBirthController.text = formattedDate;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormFieldAuthWidget(
                    hint: 'Your address',
                    label: "Address",
                    controller: addressController,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormFieldAuthWidget(
                    hint: 'Your email address',
                    label: "Email address",
                    inputAction: TextInputAction.next,
                    controller: emailController,
                    validator: (value) =>
                        EmailValidator.validate(emailController.text)
                            ? null
                            : "Please enter a valid email",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormFieldAuthWidget(
                    hint: 'Your phone number',
                    label: "Phone number",
                    inputAction: TextInputAction.next,
                    controller: phoneNumberController,
                    textInputType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Gender",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ColorUtils.textColor),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: ColorUtils.grayColor, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: ColorUtils.grayColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: ColorUtils.grayColor, width: 1),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                    items: <String>['Male', 'Female', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextButtonWidget(
                    label: 'Sign Up',
                    onPressed: _handleSignUp,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: ColorUtils.textColor,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Routes.goToSignInScreen(context),
                          child: Text(
                            'Login',
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
      ),
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authProvider.notifier)
          .register(
            fullName: fullNameController.text,
            dateOfBirth: dateOfBirthController.text,
            address: addressController.text,
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
            gender: selectedGender ?? '',
          )
          .then((_) {
        final authState = ref.read(authProvider);
        if (authState.isLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        } else {
          if (authState.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(authState.error!)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration successful')),
            );
          }
        }
      });
    }
  }
}
