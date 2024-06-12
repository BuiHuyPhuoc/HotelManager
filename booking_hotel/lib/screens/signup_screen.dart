import 'package:booking_hotel/class/api_respond.dart';
import 'package:booking_hotel/class/user.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel/screens/signin_screen.dart';
import 'package:booking_hotel/theme/theme.dart';
import 'package:booking_hotel/widgets/custom_scaffold.dart';

import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;
  DateTime selectedDate = DateTime.now();
  DateTime? _selectedDate;
  TextEditingController fullnameTextField = new TextEditingController();
  TextEditingController emailTextField = new TextEditingController();
  TextEditingController passwordTextField = new TextEditingController();
  TextEditingController dateOfBirthTextField = new TextEditingController();
  TextEditingController phoneNumberTextField = new TextEditingController();
  TextEditingController CCCDTextField = new TextEditingController();

  @override
  void dispose() {
    fullnameTextField.dispose();
    emailTextField.dispose();
    passwordTextField.dispose();
    dateOfBirthTextField.dispose();
    phoneNumberTextField.dispose();
    CCCDTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // get started text
                      Text(
                        'Sign up here',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),

                      const SizedBox(
                        height: 20.0,
                      ), //test
                      TextFormField(
                        controller: fullnameTextField,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nhập họ tên.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Họ tên'),
                          hintText: 'Nhập họ tên',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25.0,
                      ),

                      TextFormField(
                        controller: emailTextField,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nhập email.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Nhập email',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25.0,
                      ),
                      //DOB
                      TextFormField(
                        controller: dateOfBirthTextField,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Ngày sinh',
                          hintText: _selectedDate == null
                              ? 'Nhập ngày sinh'
                              : DateFormat('dd/MM/yyyy')
                                  .format(_selectedDate!), // Format the date
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                              dateOfBirthTextField.text =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 25.0),

                      // Phone Number Field
                      TextFormField(
                        controller: phoneNumberTextField,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nhập số điện thoại';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Số điện thoại'),
                          hintText: 'Nhập số điện thoại ...',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25.0,
                      ),

                      //CCCD
                      TextFormField(
                        controller: CCCDTextField,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nhập CCCD';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Số CCCD'),
                          hintText: 'Nhập số CCCD',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),

                      //PASSWORD
                      TextFormField(
                        controller: passwordTextField,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nhập mật khẩu.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Mật khẩu'),
                          hintText: 'Nhập mật khẩu.',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25.0,
                      ),

                      // i agree to the processing
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                            activeColor: lightColorScheme.primary,
                          ),
                          const Text(
                            'Tôi đồng ý với ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          Text(
                            'các điều khoản và dịch vụ.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: lightColorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 25.0,
                      ),

                      // signup button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formSignupKey.currentState!.validate() &&
                                agreePersonalData) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Đang xử lý'),
                                ),
                              );

                              User getInfo = User(
                                  userGmail: emailTextField.text,
                                  userPassword: passwordTextField.text,
                                  userName: fullnameTextField.text,
                                  dateOfBirth: dateOfBirthTextField.text,
                                  userPhone: phoneNumberTextField.text,
                                  userIdcard: CCCDTextField.text);

                              ApiResponse response = await createUser(getInfo);

                              if (!response.status) {
                                WarningToast(
                                  context: context,
                                  content: response.message,
                                  duration: Duration(seconds: 2),
                                ).ShowToast();
                                return;
                              } else {
                                SuccessToast(
                                  context: context,
                                  content: response.message,
                                ).ShowToast();
                                return;
                              }
                            } else if (!agreePersonalData) {
                              WarningToast(
                                context: context,
                                content:
                                    'Vui lòng đồng ý với các điều khoản và dịch vụ',
                                duration: Duration(seconds: 2),
                              ).ShowToast();
                              return;
                            }
                          },
                          child: const Text('Sign up'),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      // sign up divider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Sign up with',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),
                      // sign up social media logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Logo(Logos.facebook_f),
                          Logo(Logos.google),
                          Logo(Logos.apple),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),

                      // already have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
