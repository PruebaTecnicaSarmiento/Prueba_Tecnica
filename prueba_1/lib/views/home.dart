import 'package:flutter/material.dart';

import '../widgets/appbar.dart';

import '../widgets/custom_buttom_home.dart';
import '../widgets/custom_text_gradiet.dart';
import 'user_register.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Prueba Técnica'),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientText(
            'Bienvenido',
            style: const TextStyle(fontSize: 40),
            gradient: LinearGradient(colors: [
              Colors.purple.shade400,
              Colors.blue.shade900,
            ]),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.8),
                    Colors.blue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CustomButtonHome(
                text: "Registrar",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserRegistrationView(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
