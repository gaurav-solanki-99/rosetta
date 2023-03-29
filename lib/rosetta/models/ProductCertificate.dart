class Productcertificate {
  bool status;
  String message;
  String data;

  Productcertificate({this.status, this.message, this.data});

  Productcertificate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}

class Data {
  String certificateImage;

  Data({this.certificateImage});

  Data.fromJson(Map<String, dynamic> json) {
    certificateImage = json['certificate_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['certificate_image'] = this.certificateImage;
    return data;
  }
}