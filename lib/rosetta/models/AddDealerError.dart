class AddDealerError {
  
  List<dynamic> name;
  String key;

  AddDealerError({this.key});

  AddDealerError.fromJson(Map<dynamic, dynamic> json, String key2) {
    this.key=key2;
    name = json['$key'];
  }

  Map<String, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<String, dynamic>();
    data['$key'] = this.name;
    return data;
  }
}