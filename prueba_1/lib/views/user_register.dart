import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/register_user_controller.dart';
import '../providers/user_provider.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_buttom_home.dart';
import '../widgets/custom_buttom_user_register.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/text_input_format.dart';
import 'user_show.dart';

class UserRegistrationView extends StatefulWidget {
  const UserRegistrationView({Key? key}) : super(key: key);

  @override
  _UserRegistrationViewState createState() => _UserRegistrationViewState();
}

class _UserRegistrationViewState extends State<UserRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _addressController = TextEditingController();

  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();
  FocusNode nodeFour = FocusNode();

  @override
  void initState() {
    nodeOne = FocusNode();
    nodeTwo = FocusNode();
    nodeThree = FocusNode();
    nodeFour = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nodeOne.dispose();
    nodeTwo.dispose();
    nodeThree.dispose();
    nodeFour.dispose();
    _nameController.clear();
    _lastnameController.clear();
    _birthdayController.clear();
    _addressController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: MyAppBar(title: 'Registrar Usuario'),
      body: _buildBody(
          _formKey,
          _nameController,
          _lastnameController,
          _birthdayController,
          _addressController,
          nodeOne,
          nodeTwo,
          nodeThree,
          nodeFour,
          context,
          userProvider),
    );
  }
}

Widget _buildBody(
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController lastnameController,
    TextEditingController birthdayController,
    TextEditingController addressController,
    FocusNode nodeOne,
    FocusNode nodeTwo,
    FocusNode nodeThree,
    FocusNode nodeFour,
    BuildContext context,
    UserProvider userProvider) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text("Nombre",
                  style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: _buildNameField(nameController, nodeOne, nodeTwo, context),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text("Apellido",
                  style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: _buildLastNameField(
                  lastnameController, nodeTwo, nodeThree, context),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text("Fecha de nacimiento",
                  style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: _buildBirthdayField(
                  birthdayController, nodeThree, nodeFour, context),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text("Dirección",
                  style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: _buildAddressField(addressController, nodeFour, context),
            ),
            const SizedBox(height: 50),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: CustomButtonUserRegister(
                  formKey,
                  nameController,
                  lastnameController,
                  birthdayController,
                  addressController,
                  userProvider,
                  context,
                  text: "Registrar",
                  onTap: () => _registerUser(
                      formKey,
                      nameController,
                      lastnameController,
                      birthdayController,
                      addressController,
                      userProvider,
                      context),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

TextFieldCustomWidget _buildNameField(TextEditingController nameController,
    FocusNode nodeOne, FocusNode nodeTwo, BuildContext context) {
  return TextFieldCustomWidget(
    controller: nameController,
    inputType: TextInputType.name,
    focusNode: nodeOne,
    onFieldSubmitted: (value) {
      FocusScope.of(context).requestFocus(nodeTwo);
      print("Name: ${nameController.value}");
    },
    validator: _validateName,
  );
}

TextFieldCustomWidget _buildLastNameField(
    TextEditingController lastnameController,
    FocusNode nodeTwo,
    FocusNode nodeThree,
    BuildContext context) {
  return TextFieldCustomWidget(
    controller: lastnameController,
    inputType: TextInputType.name,
    focusNode: nodeTwo,
    onFieldSubmitted: (value) {
      FocusScope.of(context).requestFocus(nodeThree);
    },
    validator: _validateLastName,
  );
}

TextFieldCustomWidget _buildBirthdayField(
    TextEditingController birthdayController,
    FocusNode nodeThree,
    FocusNode nodeFour,
    BuildContext context) {
  return TextFieldCustomWidget(
    controller: birthdayController,
    inputType: TextInputType.number,
    focusNode: nodeThree,
    hintText: "DD/MM/AAAA",
    inputFormatter: [
      InputFormatter(
        sample: "DD/MM/AAAA",
        separator: "/",
      ),
    ],
    onFieldSubmitted: (value) {
      FocusScope.of(context).requestFocus(nodeFour);
    },
    validator: _validateBirthday,
  );
}

TextFieldCustomWidget _buildAddressField(
    TextEditingController addressController,
    FocusNode nodeFour,
    BuildContext context) {
  return TextFieldCustomWidget(
      controller: addressController,
      inputType: TextInputType.text,
      focusNode: nodeFour,
      onFieldSubmitted: (value) {},
      validator: _validateAddress);
}

String? _validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, introduce un nombre';
  }
  return null;
}

String? _validateLastName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, introduce un apellido';
  }
  return null;
}

String? _validateBirthday(String? value) {
  if (value == null || value.isEmpty || value.length < 10) {
    return 'Por favor, introduce una fecha de nacimiento valida';
  } else if (value.length > 1 && value.length < 3) {
    final day = int.tryParse(value);
    if (day == null || day < 1 || day > 31) {
      return 'Ingrese un día válido';
    }
  } else if (value.length > 3 && value.length < 6) {
    final day = int.tryParse(value.substring(0, 2));
    if (day == null || day < 1 || day > 31) {
      return 'Ingrese un día válido';
    }
    final month = int.tryParse(value.substring(3, 5));
    if (month == null || month < 1 || month > 12) {
      return 'Ingrese un mes válido';
    }
  } else if (value.length > 6 && value.length < 11) {
    final day = int.tryParse(value.substring(0, 2));
    if (day == null || day < 1 || day > 31) {
      return 'Ingrese un día válido';
    }
    final month = int.tryParse(value.substring(3, 5));
    if (month == null || month < 1 || month > 12) {
      return 'Ingrese un mes válido';
    }
    final year = int.tryParse(value.substring(6, 10));
    if (year == null || year < 1900 || year > DateTime.now().year) {
      return 'Ingrese un año válido';
    }
  }
  return null;
}

String? _validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, introduce una dirección';
  }
  return null;
}

ElevatedButton _buildRegisterButton(
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController lastNameController,
    TextEditingController birthdateController,
    TextEditingController addressController,
    UserProvider userProvider,
    BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
    ),
    onPressed: () => _registerUser(formKey, nameController, lastNameController,
        birthdateController, addressController, userProvider, context),
    child: const Text(
      'Registrar',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  );
}

void _registerUser(
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController lastNameController,
    TextEditingController birthdateController,
    TextEditingController addressController,
    UserProvider userProvider,
    BuildContext context) {
  List<String> addressList = [addressController.text];
  if (formKey.currentState!.validate()) {
    UserRegistrationController(userProvider: userProvider).createUser(
        name: nameController.text,
        lastName: lastNameController.text,
        birthdate: birthdateController.text,
        address: addressList);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Registro exitoso'),
      duration: Duration(seconds: 2),
    ));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UserView()));
  }
}
