// import 'package:booking_hotel/admin/booked_manager/booked_room.dart';
// import 'package:booking_hotel/class/shared_preferences.dart';
// import 'package:booking_hotel/model/login_device.dart';
// import 'package:booking_hotel/model/user.dart' as models;
// import 'package:booking_hotel/components/CustomToast.dart';
// import 'package:booking_hotel/model/user.dart';
// import 'package:booking_hotel/screens/auth_page.dart';
// import 'package:booking_hotel/screens/home_layout.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:booking_hotel/class/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel/screens/signup_screen.dart';
import 'package:booking_hotel/widgets/custom_scaffold.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  TextEditingController emailInputField = TextEditingController();
  TextEditingController passwordInputField = TextEditingController();

  @override
  void dispose() {
    emailInputField.dispose();
    passwordInputField.dispose();
    super.dispose();
  }

  void emailSignIn(BuildContext context) async {
    SignIn(context, emailInputField.text, passwordInputField.text);
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     });
    // models.User? getAccount = await getUserByEmail(emailInputField.text);
    // final getToken = await FirebaseMessaging.instance.getToken();
    // try {
    //   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: emailInputField.text, password: passwordInputField.text);
    //   if (getAccount == null) {
    //     WarningToast(
    //             context: context,
    //             content: AppLocalizations.of(context)!.userNotFound)
    //         .ShowToast();
    //     await FirebaseAuth.instance.signOut();
    //     return;
    //   }
    //   UserPreferences.saveUser(getAccount);
      
    //   //SaveDevice(LoginDevice(userId: getAccount.userId!, deviceToken: getToken!, loginStatus: true));
    //   Navigator.pop(context);
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (e) => AuthPage(),
    //     ),
    //   );
    // } catch (e) {
    //   if (getAccount != null) {
    //     UserPreferences.saveUser(getAccount);
    //     //SaveDevice(LoginDevice(userId: getAccount.userId!, deviceToken: getToken!, loginStatus: true));
    //     Navigator.pop(context);
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (e) => (getAccount.role == "Admin") ? BookedRoom() : HomeLayout(),
    //       ),
    //     );
    //   } else {
    //     WarningToast(
    //       context: context,
    //       content: AppLocalizations.of(context)!.userNotFound,
    //     ).ShowToast();
    //     Navigator.pop(context);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                  child: Form(
                key: _formSignInKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      controller: emailInputField,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseInputField(
                              AppLocalizations.of(context)!.userInfo('email'));
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                            AppLocalizations.of(context)!.userInfo('email')),
                        hintText:
                            AppLocalizations.of(context)!.userInfo('email'),
                        hintStyle: const TextStyle(),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.outline),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      controller: passwordInputField,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseInputField(
                              AppLocalizations.of(context)!
                                  .userInfo('password'));
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                            AppLocalizations.of(context)!.userInfo('password')),
                        hintText:
                            AppLocalizations.of(context)!.userInfo('password'),
                        hintStyle: const TextStyle(
                            //color: Colors.black26,
                            ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.outline),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                Theme.of(context).colorScheme.primary)),
                        child: Text(
                          AppLocalizations.of(context)!.signIn,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        onPressed: () async {
                          if (_formSignInKey.currentState!.validate()) {
                            emailSignIn(context);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.7,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signInWith,
                            style: TextStyle(
                                //color: Colors.black45,
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
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Logo(Logos.facebook_f),
                        Logo(Logos.twitter),
                        GestureDetector(
                          onTap: () {
                            AuthService().signInWithGoogle(context);
                          },
                          child: Logo(Logos.google),
                        ),
                        Logo(Logos.apple),
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    // don't have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dontHaveAccount,
                          style: TextStyle(
                              //color: Colors.black45,
                              ),
                        ),
                        SizedBox(width: 4,),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (e) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.signUp,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
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
              )),
            ),
          ),
        ],
      ),
    );
  }
}
