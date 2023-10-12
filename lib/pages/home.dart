import 'dart:async';
import 'dart:convert';
import 'package:equipment_check_sheet/component/drawer.dart';
import 'package:equipment_check_sheet/models/md_account.dart';
import 'package:equipment_check_sheet/models/md_equipment.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MAccount? oAccount;
  bool isInit = false;
  TextEditingController scnCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();
  FocusNode? focScanNode;
  FocusNode? focTxtRmkNode;
  Color? colrScan = Colors.red[100];
  Color? colrTxtRmk = Colors.red[100];
  final frmKey = GlobalKey<FormState>();
  String? EquipCode;
  MEquipmentInfo oEquip = MEquipmentInfo(
      eqpPriority: '',
      eqpId: '',
      layoutCode: '',
      objId: '',
      eqpTitle: '',
      eqpSubTitle: '',
      eqpX: '',
      eqpW: '',
      eqpY: '',
      eqpH: '',
      eqpStatus: '',
      layout: '',
      factory: '',
      eqpNextCheckDt: '',
      eqpLastCheckDt: '',
      eqpLastCheckBy: '',
      eqpRemark: '',
      eqpStartCheckDt: '',
      objMstNextDay: '',
      objMstNextMonth: '',
      objMstNextYear: '',
      eqpTrigger: '',
      eqpScale: '');
  // Future<List<MEquipInfo>>? oEquips;
  // MEquipInfo? oEquip = MEquipInfo(
  //     code: '',
  //     title: '',
  //     subTitle: '',
  //     area: '',
  //     line: '',
  //     status: '',
  //     nextCheck: '',
  //     lastBy: '',
  //     lastCheck: '');

  // Future loadData(String qrCode) async {
  //   //********* METHOD 1  ************
  //   //var data = dataEquipment['equips'] as List<dynamic>;

  //   //********* METHOD 2  ************
  //   var data = dataEquipment['equips'] as List<Map<String, String>>;

  //   //********* METHOD 3  ************
  //   // var data = dataEquipment['equips']!.cast<Map<String, String>>();

  //   debugPrint(qrCode);
  //   //********** DISPLAY WITH OBJECT ***************
  //   List<MEquipInfo> oDatas =
  //       data.map<MEquipInfo>((elm) => MEquipInfo.fromJson(elm)).toList();
  //   oDatas = oDatas.where((eq) => eq.code == qrCode).toList();
  //   if (oDatas.isNotEmpty) {
  //     setState(() {
  //       oEquip = MEquipInfo(
  //           code: oDatas[0].code,
  //           title: oDatas[0].title,
  //           subTitle: oDatas[0].subTitle,
  //           area: oDatas[0].area,
  //           line: oDatas[0].line,
  //           status: oDatas[0].status,
  //           nextCheck: oDatas[0].nextCheck,
  //           lastBy: oDatas[0].lastBy,
  //           lastCheck: oDatas[0].lastCheck);
  //     });
  //   } else {
  //     if (context.mounted) {
  //       setState(() {
  //         oEquip = MEquipInfo(
  //             code: '',
  //             title: '',
  //             subTitle: '',
  //             area: '',
  //             line: '',
  //             status: '',
  //             nextCheck: '',
  //             lastBy: '',
  //             lastCheck: '');
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('no data'),
  //         backgroundColor: Colors.red,
  //         behavior: SnackBarBehavior.floating,
  //         margin: EdgeInsets.all(30),
  //       ));
  //     }
  //   }
  // }

  Future scanLoadData(String qrCode) async {
    final response = await http.get(
      Uri.parse(
          'https://scm.dci.co.th/SafetyFireExtinguisherAPI/equipment/get/id/$qrCode'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode.toString().startsWith("2")) {
      setState(() {
        oEquip = MEquipmentInfo.fromJson(jsonDecode(response.body));
      });
    } else if (response.statusCode.toString().startsWith("4")) {
      setState(() {
        oEquip = MEquipmentInfo(
            eqpPriority: '',
            eqpId: '',
            layoutCode: '',
            objId: '',
            eqpTitle: '',
            eqpSubTitle: '',
            eqpX: '',
            eqpW: '',
            eqpY: '',
            eqpH: '',
            eqpStatus: '',
            layout: '',
            factory: '',
            eqpNextCheckDt: '',
            eqpLastCheckDt: '',
            eqpLastCheckBy: '',
            eqpRemark: '',
            eqpStartCheckDt: '',
            objMstNextDay: '',
            objMstNextMonth: '',
            objMstNextYear: '',
            eqpTrigger: '',
            eqpScale: '');
      });
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('no data'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(30),
        ));
      }
      throw Exception('no data');
    }
  }

  Future updateStatus(
      String paramQrCode, String paramRemark, String paramStatus) async {
    final response = await http.post(
        Uri.parse(
            'https://scm.dci.co.th/SafetyFireExtinguisherAPI/equipment/check'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'EqpId': paramQrCode,
          'EqpRemark': paramRemark,
          'EqpStatus': paramStatus
        }));

    if (response.statusCode.toString().startsWith("2")) {
      scanLoadData(paramQrCode);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('บันทึกเรียบร้อยแล้ว'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(30),
        ));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('no data'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(30),
        ));
      }
      throw Exception('no data');
    }
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
          focScanNode!.addListener(_onFocusChange);

          focTxtRmkNode = FocusNode();
          focTxtRmkNode!.addListener(_onFocusChange);
        }
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

  // Color focusColor(bool foc) {
  //   return (foc) ? Colors.yellow[100]! : Colors.red;
  // }

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
                                icon: CircleAvatar(
                                  backgroundColor:
                                      theme.colorScheme.inversePrimary,
                                  child: IconButton(
                                      onPressed: () async {
                                        final qrcode =
                                            await Get.toNamed('/qrcode');
                                        setState(() {
                                          scnCtrl.text = qrcode;
                                          EquipCode = qrcode;
                                          scanLoadData(qrcode);

                                          scnCtrl.text = '';
                                        });
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.qrcode,
                                        color: Colors.white,
                                      )),
                                ),
                                // suffixIcon: const Icon(FontAwesomeIcons.qrcode),
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
                            // onFieldSubmitted: (scn) {
                            //   scnCtrl.text = scn;

                            //   scanLoadData(scn);

                            //   scnCtrl.text = '';
                            // },
                          ))),
                ],
              ),
              Divider(color: Colors.yellow[900], thickness: 5),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'เลขที่ : ',
                    style: fntThin,
                  ),
                  Text(
                    '${oEquip.eqpId} (${oEquip.factory})',
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
                      'วันที่ตรวจสอบ : ',
                      style: fntThin,
                    ),
                    Text(
                      '${oEquip.eqpNextCheckDt} ',
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
                    'ตรวจสอบล่าสุด : ',
                    style: fntThin,
                  ),
                  Text(
                    ' ${oEquip.eqpLastCheckDt} ',
                    style: fntBold,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'โดย : ',
                    style: fntThin,
                  ),
                  Text(
                    ' ${oEquip.eqpLastCheckBy} ',
                    style: fntBold,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'สถานะ : ',
                    style: fntThin,
                  ),
                  Text(
                    ' ${oEquip!.eqpStatus} ',
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
                        padding: const EdgeInsets.fromLTRB(75, 0, 75, 0),
                        child: TextFormField(
                          focusNode: focTxtRmkNode,
                          controller: remarkCtrl,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            label: const Text('หมายเหตุ'),
                            hintText: 'หมายเหตุ',
                            fillColor: colrTxtRmk,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    style: BorderStyle.solid,
                                    color: theme.colorScheme.primary)),
                            focusedBorder: const OutlineInputBorder(
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
                              onPressed: () {
                                updateStatus(EquipCode!, "", "true");
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent[400]),
                              icon: const Icon(
                                FontAwesomeIcons.squareCheck,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'ปกติ',
                                style: TextStyle(color: Colors.white),
                              )),
                          ElevatedButton.icon(
                              onPressed: () {
                                updateStatus(EquipCode!, "", "false");
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent[400]),
                              icon: const Icon(
                                FontAwesomeIcons.squareXmark,
                                color: Colors.white,
                              ),
                              label: const Text('ผิดปกติ',
                                  style: TextStyle(color: Colors.white))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Text('${oEquip!} : ${oEquip!}'),
              // Text('${oAccount!.code} : ${oAccount!.shortName}'),
              // Text('${oAccount!.code} : ${oAccount!.shortName}'),
            ]),
      ),
      drawer: (isInit) ? wdDrawer(theme, oAccount!) : null,
    );
  }
}
