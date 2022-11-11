class ChangFavoritesModele
 {
 bool? status;
  String message = 'null';

    ChangFavoritesModele.fromjson(Map<String, dynamic?>? json) {
    status = json!['status'];
    message = json['message'];
  }

}
