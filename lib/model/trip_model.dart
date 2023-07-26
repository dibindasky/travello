class TripModel{
  String name;
  List<String> places;
  Map<String,dynamic> notes;
  String id;
    String? startDate;
    String? endDate;

  TripModel({required this.name,required this.places,required this.notes,required this.id,this.endDate,this.startDate});
}