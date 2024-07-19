import 'package:booking_hotel/class/shared_preferences.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:booking_hotel/screens/home_layout.dart';
import 'package:booking_hotel/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
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
                    return AppLocalizations.of(context)!.pleaseInputField('email');
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.userInfo('email')),
                  hintText: AppLocalizations.of(context)!.userInfo('email'),
                  hintStyle: const TextStyle(),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  floatingLabelStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
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
                    return AppLocalizations.of(context)!.pleaseInputField('password');
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.userInfo('password')),
                  hintText: AppLocalizations.of(context)!.userInfo('password'),
                  hintStyle: const TextStyle(),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  floatingLabelStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
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
              profileSettingField(() {}, Icons.dark_mode, AppLocalizations.of(context)!.darkMode),
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
                      User? loggedInUser = await loginUser(
                          emailInputField.text, passwordInputField.text);
                      if (loggedInUser == null) {
                        WarningToast(
                                context: context,
                                content: AppLocalizations.of(context)!.userNotFound)
                            .ShowToast();
                        return;
                      }
                      await UserPreferences.saveUser(loggedInUser);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (e) => const HomeLayout(),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
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
