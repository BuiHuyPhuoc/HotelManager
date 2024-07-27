import 'package:booking_hotel/class/auth_service.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/screens/signup_screen.dart';
// import 'package:booking_hotel/class/shared_preferences.dart';
// import 'package:booking_hotel/components/CustomToast.dart';
// import 'package:booking_hotel/model/user.dart';
// import 'package:booking_hotel/screens/auth_page.dart';
import 'package:booking_hotel/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class BasicLoginScreen extends StatefulWidget {
  BasicLoginScreen({super.key, required this.context});
  BuildContext context;

  @override
  State<BasicLoginScreen> createState() => _BasicLoginScreenState();
}

class _BasicLoginScreenState extends State<BasicLoginScreen> {
  final _formSignInKey = GlobalKey<FormState>();

  TextEditingController emailInputField = TextEditingController();

  TextEditingController passwordInputField = TextEditingController();

  bool isDarkmode = false;

  @override
  void initState() {
    isDarkmode = Theme.of(widget.context).brightness == Brightness.dark;
    super.initState();
  }

  @override
  void dispose() {
    isDarkmode = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.surface),
            child: Form(
              key: _formSignInKey,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.signIn.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Text(
                      AppLocalizations.of(context)!.toManageAccount,
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailInputField,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseInputField('email');
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label:
                            Text(AppLocalizations.of(context)!.userInfo('email')),
                        hintText: AppLocalizations.of(context)!.userInfo('email'),
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
                        errorStyle:
                            TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: passwordInputField,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseInputField('password');
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                            AppLocalizations.of(context)!.userInfo('password')),
                        hintText:
                            AppLocalizations.of(context)!.userInfo('password'),
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
                        errorStyle:
                            TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    profileSettingField(() {}, Icons.dark_mode,
                        AppLocalizations.of(context)!.darkMode),
                    SizedBox(
                      height: 5,
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
                            SignIn(context, emailInputField.text,
                                passwordInputField.text);
                            // User? loggedInUser = await loginUser(
                            //     emailInputField.text, passwordInputField.text);
                            // if (loggedInUser == null) {
                            //   WarningToast(
                            //           context: context,
                            //           content: AppLocalizations.of(context)!.userNotFound)
                            //       .ShowToast();
                            //   return;
                            // }
                            // await UserPreferences.saveUser(loggedInUser);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (e) => AuthPage(),
                            //   ),
                            // );
                          }
                        },
                      ),
                    ),
                    (isKeyboardOpen)
                        ? SizedBox()
                        : Column(
                            children: [
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
                                  GestureDetector(
                                    onTap: () {
                                      NotifyToast(
                                        context: context,
                                        content: AppLocalizations.of(context)!
                                            .featureIsUpdating,
                                      ).ShowToast();
                                      return;
                                    },
                                    child: Logo(Logos.facebook_f),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        NotifyToast(
                                          context: context,
                                          content: AppLocalizations.of(context)!
                                              .featureIsUpdating,
                                        ).ShowToast();
                                        return;
                                      },
                                      child: Logo(Logos.twitter)),
                                  GestureDetector(
                                    onTap: () {
                                      AuthService().signInWithGoogle(context);
                                    },
                                    child: Logo(Logos.google),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        NotifyToast(
                                          context: context,
                                          content: AppLocalizations.of(context)!
                                              .featureIsUpdating,
                                        ).ShowToast();
                                        return;
                                      },
                                      child: Logo(Logos.apple)),
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
                                  SizedBox(
                                    width: 4,
                                  ),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget profileSettingField(VoidCallback onTap, IconData icon, String text) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          )),
          (icon == Icons.dark_mode)
              ? Switch(
                  value: isDarkmode,
                  activeColor: Colors.black,
                  trackOutlineColor: WidgetStatePropertyAll<Color>(
                      Theme.of(widget.context).colorScheme.shadow),
                  onChanged: (bool value) {
                    Provider.of<ThemeProvider>(widget.context, listen: false)
                        .toggleTheme();
                    setState(() {
                      isDarkmode = !isDarkmode;
                    });
                  })
              : SizedBox()
        ],
      ),
    );
  }
}
