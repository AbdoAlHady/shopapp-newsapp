class ChangeFavoritesModal {
  late bool status;
  late String message;

  ChangeFavoritesModal.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }

}