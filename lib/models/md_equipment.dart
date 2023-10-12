class MEquipmentInfo {
  final String eqpPriority;
  final String eqpId;
  final String layoutCode;
  final String objId;
  final String eqpTitle;
  final String eqpSubTitle;
  final String eqpX;
  final String eqpW;
  final String eqpY;
  final String eqpH;
  final String eqpStatus;
  final String layout;
  final String factory;
  final String eqpNextCheckDt;
  final String eqpLastCheckDt;
  final String eqpLastCheckBy;
  final String eqpRemark;
  final String eqpStartCheckDt;
  final String objMstNextDay;
  final String objMstNextMonth;
  final String objMstNextYear;
  final String eqpTrigger;
  final String eqpScale;
  MEquipmentInfo({
    required this.eqpPriority,
    required this.eqpId,
    required this.layoutCode,
    required this.objId,
    required this.eqpTitle,
    required this.eqpSubTitle,
    required this.eqpX,
    required this.eqpW,
    required this.eqpY,
    required this.eqpH,
    required this.eqpStatus,
    required this.layout,
    required this.factory,
    required this.eqpNextCheckDt,
    required this.eqpLastCheckDt,
    required this.eqpLastCheckBy,
    required this.eqpRemark,
    required this.eqpStartCheckDt,
    required this.objMstNextDay,
    required this.objMstNextMonth,
    required this.objMstNextYear,
    required this.eqpTrigger,
    required this.eqpScale,
  });

  factory MEquipmentInfo.fromJson(Map<String, dynamic> json) {
    return MEquipmentInfo(
        eqpPriority: json['eqpPriority'].toString(),
        eqpId: json['eqpId'].toString(),
        layoutCode: json['layoutCode'].toString(),
        objId: json['objId'].toString(),
        eqpTitle: json['eqpTitle'].toString(),
        eqpSubTitle: json['eqpSubTitle'].toString(),
        eqpX: json['eqpX'].toString(),
        eqpW: json['eqpW'].toString(),
        eqpY: json['eqpY'].toString(),
        eqpH: json['eqpH'].toString(),
        eqpStatus: json['eqpStatus'].toString(),
        layout: json['layout'].toString(),
        factory: json['factory'].toString(),
        eqpNextCheckDt: json['eqpNextCheckDt'].toString(),
        eqpLastCheckDt: json['eqpLastCheckDt'].toString(),
        eqpLastCheckBy: json['eqpLastCheckBy'].toString(),
        eqpRemark: json['eqpRemark'].toString(),
        eqpStartCheckDt: json['eqpStartCheckDt'].toString(),
        objMstNextDay: json['objMstNextDay'].toString(),
        objMstNextMonth: json['objMstNextMonth'].toString(),
        objMstNextYear: json['objMstNextYear'].toString(),
        eqpTrigger: json['eqpTrigger'].toString(),
        eqpScale: json['eqpScale'].toString());
  }
}
