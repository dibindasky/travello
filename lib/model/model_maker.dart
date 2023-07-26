class DestinationModel {
  String name;
  String district;
  String catogory;
  String location;
  List images = [];
  String description;
  String id;
  int popularity;

  DestinationModel(
      {required this.catogory,
      required this.popularity,
      required this.name,
      required this.description,
      required this.location,
      required this.district,
      required this.id,
      required List images}) {
    this.images.addAll(images);
  }

}
