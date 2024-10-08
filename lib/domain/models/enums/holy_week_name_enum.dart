enum HolyWeekNameEnum {
  descanso("Descanso"),
  juevesPasion("Jueves de Pasión"),
  viernesDolores("Viernes de Dolores"),
  sabadoPasion("Sábado de Pasión"),
  domingoRamos("Domingo de Ramos"),
  lunesSanto("Lunes Santo"),
  martesSanto("Martes Santo"),
  miercolesSanto("Miércoles Santo"),
  juevesSanto("Jueves Santo"),
  viernesSanto("Viernes Santo"),
  sabadoSanto("Sábado Santo"),
  domingoResurrecion("Domingo de Resurrección");

  const HolyWeekNameEnum(this.displayName);
  final String displayName;

  static HolyWeekNameEnum fromDisplayName(String displayName) {
    return HolyWeekNameEnum.values.firstWhere(
      (e) => e.displayName == displayName,
      orElse: () => throw Exception('Invalid enum display name: $displayName'),
    );
  }
}
