import 'dart:typed_data';

import 'package:director_app_tfg/domain/repositories/holy_week_event_repository.dart';

class UploadImageToStorage {
  final HolyWeekEventRepository _holyWeekEventRepository;
  UploadImageToStorage(this._holyWeekEventRepository);

  Future<String> execute(Uint8List file, String eventId) {
    return _holyWeekEventRepository.uploadImageToStorage(file, eventId); 
  }
}
