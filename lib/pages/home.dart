import 'dart:async';
import 'dart:convert';

import 'package:equipment_check_sheet/component/home/drawer.dart';
import 'package:equipment_check_sheet/models/md_account.dart';
import 'package:equipment_check_sheet/models/md_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equipment_check_sheet/api/home/source.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MAccount? oAccount;
  bool isInit = false;
  TextEditingController scnCtrl = TextEditingController();
  FocusNode? focScanNode;
  FocusNode? focTxtRmkNode;
  Color? colrScan = Colors.red[100];
  Color? colrTxtRmk = Colors.red[100];
  final frmKey = GlobalKey<FormState>();

  void loadData() async {

   dataEquipment.cast().forEach((key, value) {
    // value.forEach((keyy, val){
    //   debugPrint('key: $keyy | val: $val');
    // });

    debugPrint('key: $key | val: $value');
    
   });
    
  }

  List<MEquipInfo> parseOTList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<MEquipInfo>((json) => MEquipInfo.fromJson(json)).toList();
  }



  @override
  void initState() {
    super.initState();

    getValidateAccount().whenComplete(
      () {
        if (oAccount!.code == '' && oAccount!.code.isEmpty) {
          Get.offAllNamed('/login');
        } else {
          setState(() {
            isInit = true;
          });
          focScanNode = FocusNode();
          // focScanNode!.requestFocus();
          focScanNode!.addListener(_onFocusChange);

          focTxtRmkNode = FocusNode();
          focTxtRmkNode!.addListener(_onFocusChange);
        }

        loadData();
      },
    );
  }

  void _onFocusChange() {
    setState(() {
      // debugPrint('${focScanNode!.hasFocus.toString()} | ${focScanNode!.hasFocus.toString()}');
      colrScan =
          (focScanNode!.hasFocus) ? Colors.yellow[50]! : Colors.red[100]!;
      colrTxtRmk =
          (focTxtRmkNode!.hasFocus) ? Colors.yellow[50]! : Colors.red[100]!;
    });
  }

  Color focusColor(bool foc) {
    return (foc) ? Colors.yellow[100]! : Colors.red;
  }

  @override
  void dispose() {
    scnCtrl.dispose();
    focScanNode!.dispose();
    focTxtRmkNode!.dispose();
    focScanNode!.removeListener(_onFocusChange);
    focTxtRmkNode!.removeListener(_onFocusChange);
    super.dispose();
  }

  Future getValidateAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      oAccount = MAccount(
        code: prefs.getString('code') ?? '',
        shortName: prefs.getString('shortName') ?? '',
        fullName: prefs.getString('fullName') ?? '',
        joinDate: DateTime.parse(
            prefs.getString('joinDate') ?? DateTime.now().toString()),
        posit: prefs.getString('posit') ?? '',
        token: prefs.getString('token') ?? '',
        role: prefs.getString('role') ?? '',
        telephone: prefs.getString('telephone') ?? '',
        logInDate: DateTime.parse(
            prefs.getString('logInDate)') ?? DateTime.now().toString()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle fntThin = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: theme.colorScheme.primary);
    TextStyle fntBold = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CHECK SHEET'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.surface,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(75, 0, 75, 0),
                          alignment: Alignment.center,
                          // color: theme.colorScheme.surfaceVariant,
                          child: TextFormField(
                            maxLength: 20,
                            autofocus: true,
                            focusNode: focScanNode,
                            controller: scnCtrl,
                            decoration: InputDecoration(
                                label: const Text('Scan QRCode'),
                                hintText: 'Scan QRCode',
                                counterText: '',
                                icon: const Icon(FontAwesomeIcons.qrcode),
                                suffixIcon: const Icon(FontAwesomeIcons.qrcode),
                                fillColor: colrScan,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent, width: 5),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 5),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onFieldSubmitted: (scn) {
                              scnCtrl.text = scn;
                            },
                          ))),
                ],
              ),
              Divider(color: Colors.yellow[900], thickness: 5),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Code : ',
                    style: fntThin,
                  ),
                  Text(
                    'FA1-001-0001',
                    style: fntBold,
                  ),
                ],
              ),
              Wrap(children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Area : ',
                      style: fntThin,
                    ),
                    Text(
                      'Factory 1 - Line Main Assembly',
                      style: fntBold,
                    ),
                  ],
                ),
              ]),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Statue : ',
                    style: fntThin,
                  ),
                  Text(
                    'ปกติ',
                    style: fntBold,
                  ),
                ],
              ),
              Divider(
                color: Colors.yellow[900],
                thickness: 5,
                height: 5,
              ),
              Form(
                key: frmKey,
                child: Container(
                  // margin: EdgeInsets.only(top: 10),
                  color: theme.highlightColor,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(75, 0, 75, 0),
                        child: TextFormField(
                          focusNode: focTxtRmkNode,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            label: Text('หมายเหตุ'),
                            hintText: 'หมายเหตุ',                            
                            fillColor: colrTxtRmk,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    style: BorderStyle.solid,
                                    color: theme.colorScheme.primary)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  style: BorderStyle.solid,
                                  color: Colors.yellow),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent[400]),
                              icon: const Icon(FontAwesomeIcons.squareCheck, color: Colors.white,),
                              label: Text('ปกติ', style: TextStyle(color: Colors.white),)),
                          ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent[400]),
                              icon: const Icon(FontAwesomeIcons.squareXmark, color: Colors.white,),
                              label: Text('ผิดปกติ', style: TextStyle(color: Colors.white))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text('${focTxtRmkNode!.hasFocus} : ${focScanNode!.hasFocus}'),
              Text('${oAccount!.code} : ${oAccount!.shortName}'),
              Text('${oAccount!.code} : ${oAccount!.shortName}'),
            ]),
      ),
      drawer: (isInit) ? wdDrawer(theme, oAccount!) : null,
    );
  }
}
