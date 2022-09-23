class Favorite {
  String? cargoId;

  Favorite({this.cargoId});

  Favorite.fromJson(Map<String, dynamic> json) {
    cargoId = json['cargoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cargoId'] = this.cargoId;
    return data;
  }
}