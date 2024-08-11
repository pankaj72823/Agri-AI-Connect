import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Model/crop_data_model.dart';

class CropDataNotifier extends StateNotifier<CropDataModel?> {
  CropDataNotifier() : super(null);

  void setCropData(CropDataModel cropData) {
    state = cropData;
    // Here you can add the logic to store the data in a database
  }
}

final cropDataProvider =
StateNotifierProvider<CropDataNotifier, CropDataModel?>(
        (ref) => CropDataNotifier());