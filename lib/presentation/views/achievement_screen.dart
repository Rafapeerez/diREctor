import 'package:director_app_tfg/config/constants.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AchievementView extends ConsumerWidget {
  const AchievementView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int totalEventsAttended = ref.watch(userProvider).totalEventsAttendance;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Eventos Asistidos: $totalEventsAttended',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final achievement in achievements)
                    AchievementProgress(
                      totalEventsAttended: totalEventsAttended,
                      achievement: achievement,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Achievement {
  final int threshold;
  final String label;
  final IconData icon;

  Achievement({
    required this.threshold,
    required this.label,
    required this.icon,
  });
}

final List<Achievement> achievements = [
  Achievement(threshold: 0, label: 'Inicio', icon: Icons.flag),
  Achievement(
      threshold: Constants.FIRST_ACHIEVEMENT,
      label: 'Bronce',
      icon: Icons.looks_one),
  Achievement(
      threshold: Constants.SECOND_ACHIEVEMENT,
      label: 'Plata',
      icon: Icons.looks_two),
  Achievement(
      threshold: Constants.THIRD_ACHIEVEMENT,
      label: 'Oro',
      icon: Icons.looks_3),
  Achievement(
      threshold: Constants.FOURTH_ACHIEVEMENT,
      label: 'Platino',
      icon: Icons.looks_4),
  Achievement(
      threshold: Constants.FIFTH_ACHIEVEMENT,
      label: 'Rubí',
      icon: Icons.looks_5),
  Achievement(
      threshold: Constants.SIXTH_ACHIEVEMENT,
      label: 'Diamante',
      icon: Icons.looks_6),
];

class AchievementProgress extends StatelessWidget {
  final int totalEventsAttended;
  final Achievement achievement;

  const AchievementProgress({
    Key? key,
    required this.totalEventsAttended,
    required this.achievement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int nextThreshold =
        achievement.threshold == Constants.SIXTH_ACHIEVEMENT + 1
            ? Constants.SIXTH_ACHIEVEMENT + 1
            : (achievements.indexOf(achievement) < achievements.length - 1
                ? achievements[achievements.indexOf(achievement) + 1].threshold
                : achievement.threshold + 25);

    final double percent = (totalEventsAttended >= achievement.threshold &&
            totalEventsAttended < nextThreshold)
        ? (totalEventsAttended - achievement.threshold) /
            (nextThreshold - achievement.threshold)
        : (totalEventsAttended >= nextThreshold ? 1.0 : 0.0);

    return Column(
      children: [
        AchievementIcon(
          icon: achievement.icon,
          label: achievement.label,
          achieved: totalEventsAttended > achievement.threshold,
        ),
        const SizedBox(height: 10),
        LinearPercentIndicator(
          width: 100.0,
          lineHeight: 20.0,
          percent: percent,
          backgroundColor: Colors.grey[300],
          progressColor:
              getProgressColor(totalEventsAttended, achievement.threshold),
        ),
      ],
    );
  }
}

class AchievementIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool achieved;

  const AchievementIcon({
    Key? key,
    required this.icon,
    required this.label,
    required this.achieved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: achieved ? Colors.green : Colors.grey,
            size: 40,
          ),
          Text(
            label,
            style: TextStyle(
              color: achieved ? Colors.green : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

Color getProgressColor(int totalEvents, int threshold) {
  if (totalEvents > Constants.SIXTH_ACHIEVEMENT) return Colors.purple;
  if (totalEvents > Constants.FIFTH_ACHIEVEMENT) return Colors.pink.shade900;
  if (totalEvents > Constants.FOURTH_ACHIEVEMENT) return Colors.blueAccent;
  if (totalEvents > Constants.THIRD_ACHIEVEMENT) return Colors.amber;
  if (totalEvents > Constants.SECOND_ACHIEVEMENT) return Colors.grey.shade600;
  if (totalEvents > Constants.FIRST_ACHIEVEMENT)
    return const Color(0xFFCD7F32); // Bronze color
  return Colors.redAccent;
}
