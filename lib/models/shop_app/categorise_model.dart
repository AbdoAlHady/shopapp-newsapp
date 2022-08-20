class CategoriseModel{
  late bool status;
  late CategoriseDataModel data;
  CategoriseModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=CategoriseDataModel.fromJson(json['data']);
  }

}
class CategoriseDataModel{

  late int currentPage;
  late List <DataModel>data=[];


  CategoriseDataModel.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });

  }

}
class DataModel{
  late int id;
 late String name;
 late String image;
  DataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }


}