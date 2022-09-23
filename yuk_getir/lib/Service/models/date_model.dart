class Date {
  String? startOption;
  String? startDate;
  String? endOption;
  String? endDate;

  Date({this.startOption, this.startDate, this.endOption, this.endDate});

  Date.fromJson(Map<String, dynamic> json) {
    startOption = json['startOption'];
    startDate = json['startDate'];
    endOption = json['endOption'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startOption'] = this.startOption;
    data['startDate'] = this.startDate;
    data['endOption'] = this.endOption;
    data['endDate'] = this.endDate;
    return data;
  }
}