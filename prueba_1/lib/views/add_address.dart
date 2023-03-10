import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/register_user_controller.dart';
import '../providers/user_provider.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_text_field.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({Key? key}) : super(key: key);

  @override
  _AddAddressViewState createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();

  FocusNode nodeOne = FocusNode();

  @override
  void initState() {
    nodeOne = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nodeOne.dispose();
    _addressController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:  MyAppBar(title: 'Registrar Nueva Dirección'),
      body: _buildBody(
          _formKey, _addressController, nodeOne, context, userProvider),
    );
  }
}

Widget _buildBody(
  GlobalKey<FormState> formKey,
  TextEditingController addressController,
  FocusNode nodeOne,
  BuildContext context,
  UserProvider userProvider,
) {
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
              child: Text("Dirección",
                  style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: _buildAddressField(addressController, nodeOne, context),
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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _buildRegisterButton(
                    formKey, addressController, userProvider, context),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

TextFieldCustomWidget _buildAddressField(
    TextEditingController addressController,
    FocusNode nodeOne,
    BuildContext context) {
  return TextFieldCustomWidget(
      controller: addressController,
      inputType: TextInputType.text,
      focusNode: nodeOne,
      onFieldSubmitted: (value) {},
      validator: _validateAddress);
}

String? _validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, introduce una dirección';
  }
  return null;
}

ElevatedButton _buildRegisterButton(
    GlobalKey<FormState> formKey,
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
    onPressed: () {
      _registerUser(formKey, addressController, userProvider, context);
      
    },
    child: const Text(
      'Registrar',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  );
}

void _registerUser(GlobalKey<FormState> formKey,
    TextEditingController addressController, UserProvider userProvider, BuildContext context) {
  if (formKey.currentState!.validate()) {
    UserRegistrationController(userProvider: userProvider)
        .addAddress(address: addressController.text);
    Navigator.pop(context);
  }
}
