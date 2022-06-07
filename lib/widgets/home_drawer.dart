import 'package:flutter/material.dart';
import 'package:rescue_army/models/user.dart';
import 'package:rescue_army/services/auth/app_auth_provider.dart';
import 'package:rescue_army/stores/app_store.dart';
import 'package:rescue_army/utils/routes.dart';
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
  AppStore store = VxState.store;
  @override
  void initState() {
    super.initState();
    _getCurrentUserInfo();
  }

  User user = User();
  _getCurrentUserInfo() async {
    if (store.user == null) {
      SetUser();
    }
    user = store.user!;
    if (user.username == "" || user.username == null) {
      // user = (await AppAuthProvider().currentUser)!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture:
                user.avatar != null && user.avatar!.isNotEmpty
                    ? (Constants.API_ENDPOINT + "" + user.avatar.toString())
                        .circularNetworkImage()
                    : CircleAvatar(
                        child: Text(user.username != null
                            ? user.username!.substring(0, 1)
                            : "")),
            accountName:
                (user.username ?? '').text.make().scale(scaleValue: 1.4).px(18),
            accountEmail: (user.email ?? '').text.make(),
            decoration: const BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage("assets/images/drawer_header.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text('Edit Profile'),
            onTap: () {
              // _getCurrentUserInfo();
              Navigator.pushNamed(context, AppRoutes.profile);
              // Navigator.pop(context);
            },
          ),
          // ListTile(
          //   title: Text('Settings'),
          //   onTap: () {},
          // ),
          Divider(),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              // auth.FirebaseAuth.instance.signOut();
              Navigator.popAndPushNamed(context, AppRoutes.signin);
            },
          ),
        ],
      ),
    );
  }
}
