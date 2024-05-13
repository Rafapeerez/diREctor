import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedHolyWeekEventProvider = StateProvider<HolyWeekEvent?>((ref) => HolyWeekEvent.empty());
