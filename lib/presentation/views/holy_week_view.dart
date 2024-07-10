import 'package:director_app_tfg/presentation/providers/holy_week_event/holy_week_event_provider.dart';
import 'package:director_app_tfg/presentation/widgets/custom_holy_week_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HolyWeekView extends ConsumerWidget {
  const HolyWeekView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holyWeekEventsAsyncValue = ref.watch(holyWeekEventsProvider);

    return holyWeekEventsAsyncValue.when(
      data: (holyWeekEvents) => ListView.builder(
        itemCount: holyWeekEvents.length,
        itemBuilder: (context, index) {
          final holyWeekEvent = holyWeekEvents[index];
          return Column(
            children: [
              CustomHolyWeekCard(
                holyWeekEvent: holyWeekEvent,
              )
            ],
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
