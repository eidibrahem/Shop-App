class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromjson(Map<String, dynamic?>? json) {
    status = json!['status'];

    data =
        json['data'] != null ? new CategoriesDataModel.fromjson(json['data']) : null;
  }
}

class CategoriesDataModel {
  int? current_page;
  List<DataModel>? data;
  CategoriesDataModel(List<DataModel>? elments) {
    if (elments != null) {
      this.data = elments;
    }
  }

  CategoriesDataModel.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(new DataModel.fromjson(v));
      });
    }
  }
}

class DataModel {
  int? id;
  String? image;
  String? name;
  
  DataModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}
