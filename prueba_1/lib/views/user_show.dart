import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/appbar.dart';
import 'add_address.dart';

const fontStyle1 =
    TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black);
const fontStyle2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(19, 202, 206, 1));
const fontStyle3 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(153, 51, 255, 1));

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar(title: 'Usuario'),
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final height = size.height;
  final width = size.width;
  return Consumer<UserProvider>(
    builder: (context, userProvider, _) {
      final user = userProvider.user;
      if (user == null) {
        return const Center(
          child: Text('Sin Usuarios'),
        );
      } else {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: height * 0.2,
                    width: width * 0.4,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: userProvider.avatar != null
                                ? FileImage(userProvider.avatar!)
                                : const AssetImage("assets/Avatar.png")
                                    as ImageProvider<Object>?,
                          ),
                          // Image.asset("assets/Avatar.png"),
                          FloatingActionButton(
                            elevation: 1,
                            backgroundColor:
                                const Color.fromRGBO(153, 51, 255, 1),
                            child: const Icon(Icons.edit),
                            onPressed: () async {
                              final pickedFile = await ImagePicker().getImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 50,
                                  maxWidth: 400);
                              if (pickedFile != null) {
                                final File image = File(pickedFile.path);
                                userProvider.updateAvatar(image);
                              }
                            },
                          )
                        ]),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Informacion Principal',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ]),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      width: 350,
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Nombre',
                            style: fontStyle2,
                          ),
                          Text(
                            user.name,
                            style: fontStyle1,
                          ),
                          const Divider(thickness: 1),
                          const Text(
                            'Apellido',
                            style: fontStyle2,
                          ),
                          Text(
                            user.lastName,
                            style: fontStyle1,
                          ),
                          const Divider(thickness: 1),
                          const Text(
                            'Fecha de Nacimiento',
                            style: fontStyle2,
                          ),
                          Text(
                            user.birthdate,
                            style: fontStyle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Informacion Secundaria',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ]),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      width: 360,
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Direcciones',
                            style: fontStyle2,
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: userProvider.user.address
                                .map((address) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(address,
                                            style: const TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        if (address !=
                                            userProvider.user.address.last)
                                          const Divider(thickness: 1),
                                      ],
                                    ))
                                .toList(),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddAddressView()));
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.add,
                                    color: Color.fromRGBO(153, 51, 255, 1),
                                  ),
                                  Text(
                                    ' Agregar Nueva Dirección',
                                    style: fontStyle3,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        );
      }
    },
  );
}
