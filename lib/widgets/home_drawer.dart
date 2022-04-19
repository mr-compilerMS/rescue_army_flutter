import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/constants.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  void initState() {
    super.initState();
    _getCurrentUserInfo();
  }

  Map<String, dynamic> user = {};

  _getCurrentUserInfo() async {
    get(Uri.parse(Constants.API_ENDPOINT + '/core/me'), headers: {
      'Authorization':
          "Token " + await FirebaseAuth.instance.currentUser!.getIdToken()
    }).then((value) {
      setState(() {
        user = jsonDecode(value.body);
      });
    });
    print(await FirebaseAuth.instance.currentUser!.getIdToken());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: user.containsKey('avatar') &&
                    user['avatar'] != null &&
                    user['avatar'] != ''
                ? (Constants.API_ENDPOINT + "" + user['avatar'].toString())
                    .circularNetworkImage()
                : 'https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1961&q=80'
                    .circularNetworkImage(),
            accountName: user.containsKey('name')
                ? user['name'].toString().text.make()
                : 'Sanna Marin'.text.make().scale(scaleValue: 1.4).px(18),
            accountEmail: 'sannamarin@gmail.com'.text.make(),
            decoration: const BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(
                    'https://media.istockphoto.com/photos/camouflage-cloth-texture-abstract-background-and-texture-for-design-picture-id1287561722?b=1&k=20&m=1287561722&s=170667a&w=0&h=1J3t8Ed8FF9Nem9kDlFpMI5_x8vrgoIUdgzK23iYC-A='),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text('Edit Profile'),
            onTap: () {
              _getCurrentUserInfo();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
