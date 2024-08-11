class CropDataModel {
  final double acresOfLand;
  final String locationOfField;
  final List<String> typesOfCrops;
  final String maximumCrops;

  CropDataModel({
    required this.acresOfLand,
    required this.locationOfField,
    required this.typesOfCrops,
    required this.maximumCrops,
  });

  Map<String, dynamic> toMap() {
    return {
      'acres_of_land': acresOfLand,
      'location_of_field': locationOfField,
      'types_of_crops': typesOfCrops,
      'maximum_crops': maximumCrops,
    };
  }
}