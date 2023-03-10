import 'package:flutter/services.dart';

class InputFormatter extends TextInputFormatter {
  final String sample;
  final String separator;

  InputFormatter({required this.sample, required this.separator});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > sample.length) return oldValue;

        if (newValue.text.length == 3) {
          if (int.parse(newValue.text.substring(0, 2)) > 31) {
            return TextEditingValue(
                text: oldValue.text,
                selection:
                    TextSelection.collapsed(offset: oldValue.selection.end));
          }
          if (newValue.text.substring(2, 3) != separator) {
            return TextEditingValue(
                text:
                    '${oldValue.text.substring(0, 2)}$separator${oldValue.text.substring(2)}',
                selection: TextSelection.collapsed(
                    offset: oldValue.selection.end + 1));
          }
        } else if (newValue.text.length == 6) {
          if (int.parse(newValue.text.substring(3, 5)) > 12 ||
              int.parse(newValue.text.substring(3, 5)) == 0) {
            return TextEditingValue(
                text: oldValue.text,
                selection:
                    TextSelection.collapsed(offset: oldValue.selection.end));
          }
          if (newValue.text.substring(5, 6) != separator) {
            return TextEditingValue(
                text:
                    '${oldValue.text.substring(0, 5)}$separator${oldValue.text.substring(5)}',
                selection: TextSelection.collapsed(
                    offset: oldValue.selection.end + 1));
          }
        } else if (newValue.text.length == 10) {
          int? year = int.tryParse(newValue.text.substring(6));
          if (year == null || year < 1900 || year > 2023) {
            return TextEditingValue(
                text: oldValue.text,
                selection:
                    TextSelection.collapsed(offset: oldValue.selection.end));
          }
        }
      }
    }
    return newValue;
  }
}
