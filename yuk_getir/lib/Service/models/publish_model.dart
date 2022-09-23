import 'date_model.dart';

class Publish {
  String? type;
  bool? hasBargain;
  Date? date;
  String? paymentMethod;
  num? offerPrice;
  bool? vatIncluded;
  String? currency;

  Publish(
      {this.type,
      this.hasBargain,
      this.date,
      this.paymentMethod,
      this.offerPrice,
      this.vatIncluded,
      this.currency});

  Publish.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    hasBargain = json['hasBargain'];
    date = json['date'] != null ?  Date.fromJson(json['date']) : null;
    paymentMethod = json['paymentMethod'];
    offerPrice = json['offerPrice'];
    vatIncluded = json['vatIncluded'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['type'] = this.type;
    data['hasBargain'] = this.hasBargain;
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    data['paymentMethod'] = this.paymentMethod;
    data['offerPrice'] = this.offerPrice;
    data['vatIncluded'] = this.vatIncluded;
    data['currency'] = this.currency;
    return data;
  }
}