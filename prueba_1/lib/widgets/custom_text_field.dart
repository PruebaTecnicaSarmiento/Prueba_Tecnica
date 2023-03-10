import 'package:flutter/material.dart';

import 'text_input_format.dart';

class TextFieldCustomWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final FocusNode? focusNode;
  final int? maxlength;
  final String? errorText;

  final List<InputFormatter>? inputFormatter;

  const TextFieldCustomWidget({
    Key? key,
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    this.focusNode,
    this.inputFormatter,
    this.maxlength,
    this.errorText,
  }) : super(key: key);

  @override
  _FormIconContainerWidgetState createState() =>
      _FormIconContainerWidgetState();
}

class _FormIconContainerWidgetState extends State<TextFieldCustomWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      // height: size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        scrollPadding: EdgeInsets.only(bottom: 100),
        focusNode: widget.focusNode,
        style: const TextStyle(color: Colors.black),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        maxLength: widget.maxlength,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.inputFormatter,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          // filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
