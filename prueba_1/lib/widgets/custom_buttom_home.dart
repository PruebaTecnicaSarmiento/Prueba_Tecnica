

import 'package:flutter/material.dart';

import '../models/abstract_buttom.dart';

class CustomButtonHome extends AbstractButton {
  

  const CustomButtonHome({super.key, 
    required String text,
    required Function onTap
  }) : super(
          text: text,
          onTap: onTap
        );

  @override
  _CustomButtonHomeState createState() => _CustomButtonHomeState();
}

class _CustomButtonHomeState extends State<CustomButtonHome> {
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