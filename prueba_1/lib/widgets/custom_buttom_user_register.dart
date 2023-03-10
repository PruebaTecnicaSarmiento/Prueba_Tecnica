

import 'package:flutter/material.dart';

import '../models/abstract_buttom.dart';
import '../providers/user_provider.dart';

class CustomButtonUserRegister extends AbstractButton {
  final GlobalKey<FormState> formKey;
  final  TextEditingController nameController;
  final  TextEditingController lastNameController;
  final  TextEditingController birthdateController;
  final  TextEditingController addressController;
  final  UserProvider userProvider;
   final BuildContext context;

  const CustomButtonUserRegister(this.formKey, this.nameController, this.lastNameController, this.birthdateController, this.addressController, this.userProvider, this.context, {super.key, 
    required String text,
    required Function onTap
  }) : super(
          text: text,
          onTap: onTap
        );

  @override
  _CustomButtonUserRegisterState createState() => _CustomButtonUserRegisterState();
}

class _CustomButtonUserRegisterState extends State<CustomButtonUserRegister> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: () {
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        width: _isPressed ? 90 : 120,
        height: _isPressed ? 50 : 60,
        decoration: BoxDecoration(
          gradient: _isPressed
              ? null
              : LinearGradient(
                  colors: [
                    Colors.lightBlue,
                    Colors.purple.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: _isPressed ? Colors.grey[400] : null,
          borderRadius: BorderRadius.circular(_isPressed ? 16.0 : 30.0),
        ),
        child: AnimatedOpacity(
          opacity: _isPressed ? 0.7 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}