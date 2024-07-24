import 'package:booking_hotel/class/user_preferences.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController fullnameTextField = new TextEditingController();
  TextEditingController emailTextField = new TextEditingController();
  TextEditingController dateOfBirthTextField = new TextEditingController();
  TextEditingController phoneNumberTextField = new TextEditingController();
  TextEditingController CCCDTextField = new TextEditingController();
  DateTime? _selectedDate;

  User? user;
  void GetUser() async {
    user = await UserPreferences.getUser();
  }
  @override void initState() {
    GetUser();
    super.initState();
  }
  @override
  void dispose() {
    fullnameTextField.dispose();
    emailTextField.dispose();
    dateOfBirthTextField.dispose();
    phoneNumberTextField.dispose();
    CCCDTextField.dispose();
    super.dispose();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            "Sửa thông tin",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 42,
                ),
                child: Column(
                  children: [
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
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          floatingLabelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusColor: Theme.of(context).colorScheme.onSurface),
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
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Theme.of(context).colorScheme.onSurface,
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
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Theme.of(context).colorScheme.onSurface,
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
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Theme.of(context).colorScheme.onSurface,
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
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Theme.of(context).colorScheme.onSurface,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary),
            onPressed: () {},
            child: Text(
              "Cập nhật",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
