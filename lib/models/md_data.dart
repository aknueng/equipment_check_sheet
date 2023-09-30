class MEquipInfo {
  final String code;
  final String title;
  final String subTitle;
  final String area;
  final String line;
  final String status;
  final String nextCheck;
  final String lastBy;
  final String lastCheck;

  MEquipInfo({
    required this.code,
    required this.title,
    required this.subTitle,
    required this.area,
    required this.line,
    required this.status,
    required this.nextCheck,
    required this.lastBy,
    required this.lastCheck,
  });

  factory MEquipInfo.fromJson(Map<String, dynamic> json) {
    return MEquipInfo(
        code: json['code'].toString(),
        title: json['title'].toString(),
        subTitle: json['subTitle'].toString(),
        area: json['area'].toString(),
        line: json['line'].toString(),
        status: json['status'].toString(),
        nextCheck: json['nextCheck'].toString(),
        lastBy: json['lastBy'].toString(),
        lastCheck: json['lastCheck'].toString());
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'title': title,
        'subTitle': subTitle,
        'area': area,
        'line': line,
        'status': status,
        'nextCheck': nextCheck,
        'lastBy': lastBy,
        'lastCheck': lastCheck,
      };
}
