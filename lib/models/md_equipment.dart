class MEquipmentInfo {
  final String eqpId;
  final String layoutCode;
  final String objId;
  final String eqpTitle;
  final String eqpSubTitle;
  final String eqpLastCheckDt;
  final String eqpNextCheckDt;
  final String eqpLastCheckBy;
  final String eqpStatus;
  final String layout;
  final String factory;
  final String shortname;
  final String objSvg;

  MEquipmentInfo(
      {required this.eqpId,
      required this.layoutCode,
      required this.objId,
      required this.eqpTitle,
      required this.eqpSubTitle,
      required this.eqpLastCheckDt,
      required this.eqpNextCheckDt,
      required this.eqpLastCheckBy,
      required this.eqpStatus,
      required this.layout,
      required this.factory,
      required this.shortname,
      required this.objSvg});

  factory MEquipmentInfo.fromJson(Map<String, dynamic> json) {
    return MEquipmentInfo(
        eqpId: json['eqpId'].toString(),
        layoutCode: json['layoutCode'].toString(),
        objId: json['objId'].toString(),
        eqpTitle: json['eqpTitle'].toString(),
        eqpSubTitle: json['eqpSubTitle'].toString(),
        eqpLastCheckDt: json['eqpLastCheckDt'].toString(),
        eqpNextCheckDt: json['eqpNextCheckDt'].toString(),
        eqpLastCheckBy: json['eqpLastCheckBy'].toString(),
        eqpStatus: json['eqpStatus'].toString(),
        layout: json['layout'].toString(),
        factory: json['factory'].toString(),
        shortname: json['shortname'].toString(),
        objSvg: json['objSvg'].toString());
  }
}
