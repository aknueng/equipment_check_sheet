import 'package:equipment_check_sheet/models/md_account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SafeArea wdDrawer(ThemeData theme, MAccount oAccount) {
  return SafeArea(
    child: Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://www.dci.co.th/PublishService/Picture/${oAccount.code}.JPG',
              ),
              backgroundColor: Colors.white,
            ),
            accountName: Text(oAccount.shortName),
            accountEmail: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Position : ${oAccount.posit}'),
                Text('Telephone : ${oAccount.telephone}')
              ],
            ),
          ),
          //const Divider(),

          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              child: ListTile(
                tileColor: theme.colorScheme.primary,
                titleAlignment: ListTileTitleAlignment.center,
                leading: const Icon(FontAwesomeIcons.rightFromBracket,
                    color: Colors.white),
                title: const Text(
                  'ออกจากระบบ',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.remove('code');
                  prefs.remove('shortName');
                  prefs.remove('fullName');
                  prefs.remove('joinDate');
                  prefs.remove('posit');
                  prefs.remove('token');
                  prefs.remove('role');
                  prefs.remove('telephone');
                  prefs.remove('logInDate');

                  // setState(() {
                  //   oAccount = MAccount(
                  //       code: '',
                  //       shortName: '',
                  //       fullName: '',
                  //       joinDate: DateTime.now(),
                  //       posit: '',
                  //       token: '',
                  //       role: '',
                  //       telephone: '',
                  //       logInDate: DateTime.now());
                  // });
                  Get.offAllNamed('/login');
                },
              ),
            ),
          ))
        ],
      ),
    ),
  );
}
