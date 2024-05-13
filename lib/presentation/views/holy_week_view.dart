import 'package:director_app_tfg/domain/models/enums/holy_week_name_enum.dart';
import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/presentation/widgets/custom_holy_week_card.dart';
import 'package:flutter/material.dart';

class HolyWeekView extends StatelessWidget {
  const HolyWeekView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ListView(
          children: [
            CustomHolyWeekCard(
              holyWeekEvent: HolyWeekEvent.create(
                name: HolyWeekNameEnum.juevesPasion, 
                date: DateTime(2025, 4, 10, 19, 40),
                location: "Parroquia de Nuestra Señora del Carmen Puerta Nueva",
                duration: const Duration(hours: 5)
              ),
              name: HolyWeekNameEnum.juevesPasion,
              image:'lib/config/assets/images/JuevesPasion.jpg', 
              route: '/home/1/holyweekdetails-screen'
            ),

            const CustomHolyWeekCard(
              name: HolyWeekNameEnum.viernesDolores,
              image:'lib/config/assets/images/Descanso.png', 
            ),

            CustomHolyWeekCard(
              holyWeekEvent: HolyWeekEvent.create(
                name: HolyWeekNameEnum.sabadoPasion, 
                date: DateTime(2025, 4, 12, 14, 30),
                location: "Parroquia San Vicente Ferrer Cordoba",
                duration: const Duration(hours: 8, minutes: 15)
              ),
              name: HolyWeekNameEnum.sabadoPasion,
              image:'lib/config/assets/images/SabadoPasion.jpg', 
              route: '/home/1/holyweekdetails-screen'
            ),

            CustomHolyWeekCard(
              holyWeekEvent: HolyWeekEvent.create(
                name: HolyWeekNameEnum.domingoRamos, 
                date: DateTime(2025, 4, 13, 16, 30),
                location: "Iglesia de San Francisco y San Eulogio",
                duration: const Duration(hours: 6)
              ),
              name: HolyWeekNameEnum.domingoRamos,
              image:'lib/config/assets/images/DomingoRamos.jpg', 
              route: '/home/1/holyweekdetails-screen'
            ),

            CustomHolyWeekCard(
              holyWeekEvent: HolyWeekEvent.create(
                name: HolyWeekNameEnum.lunesSanto, 
                date: DateTime(2025, 4, 14, 15, 15),
                location: "Parroquia de San Fernando Cordoba",
                duration: const Duration(hours: 9, minutes: 15)
              ),
              name: HolyWeekNameEnum.lunesSanto,
              image:'lib/config/assets/images/LunesSanto.jpeg', 
              route: '/home/1/holyweekdetails-screen'
            ),

            const CustomHolyWeekCard(
              name: HolyWeekNameEnum.martesSanto,
              image:'lib/config/assets/images/Descanso.png', 
            ),

            CustomHolyWeekCard(
              holyWeekEvent: HolyWeekEvent.create(
                name: HolyWeekNameEnum.miercolesSanto, 
                date: DateTime(2025, 4, 16, 20, 00),
                location: "Parroquia Nuestra Señora de las Nieves, La Rinconada",
                duration: const Duration(hours: 4),
                moreInformation: "Hay que estar a las 18 de la tarde en el local de ensayo"
              ),
              name: HolyWeekNameEnum.miercolesSanto,
              image:'lib/config/assets/images/MiercolesSanto.jpg', 
              route: '/home/1/holyweekdetails-screen'
            ),

            CustomHolyWeekCard(
              holyWeekEvent: HolyWeekEvent.create(
                name: HolyWeekNameEnum.juevesSanto, 
                date: DateTime(2025, 4, 17, 17, 15),
                location: "Hermandad de la Sagrada Cena, Málaga",
                duration: const Duration(hours: 6, minutes: 15),
                moreInformation: "Hay que estar a las 14 de la tarde en el local de ensayo"
              ),
              name: HolyWeekNameEnum.juevesSanto,
              image:'lib/config/assets/images/JuevesSanto.jpg', 
              route: '/home/1/holyweekdetails-screen'
            ),

            CustomHolyWeekCard(
              holyWeekEvent: HolyWeekEvent.create(
                name: HolyWeekNameEnum.viernesSanto, 
                date: DateTime(2025, 4, 18, 16, 20),
                location: "Parroquia Nuestra Señora del Rosario y Santa Beatriz De Silva",
                duration: const Duration(hours: 9, minutes: 50)
              ),
              name: HolyWeekNameEnum.viernesSanto,
              image:'lib/config/assets/images/ViernesSanto.jpg', 
              route: '/home/1/holyweekdetails-screen'
            ),

            const CustomHolyWeekCard(
              name: HolyWeekNameEnum.sabadoSanto,
              image:'lib/config/assets/images/Descanso.png', 
            ),

            CustomHolyWeekCard(
              holyWeekEvent: HolyWeekEvent.create(
                name: HolyWeekNameEnum.domingoResurrecion, 
                date: DateTime(2025, 4, 20, 10, 30), 
                location: "Ermita de la Virgen de Gracia, Montoro",
                duration: const Duration(hours: 4, minutes: 45),
                moreInformation: "Hay que estar a las 8 de la mañana en el local de ensayo"
              ),
              name: HolyWeekNameEnum.domingoResurrecion,
              image:'lib/config/assets/images/DomingoResurreccion.jpeg', 
              route: '/home/1/holyweekdetails-screen'
            ),
            const SizedBox(height: 10)
          ],
    );
  }
}
