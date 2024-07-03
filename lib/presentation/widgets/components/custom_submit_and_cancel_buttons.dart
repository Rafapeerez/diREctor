import 'package:flutter/material.dart';

class SubmitAndCancelButtons extends StatelessWidget {
  final VoidCallback onCancelPressed;
  final VoidCallback onSubmitedPressed;

  const SubmitAndCancelButtons({
    super.key, 
    required this.onCancelPressed, 
    required this.onSubmitedPressed
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: onCancelPressed,
          child: const Text("Cancelar")
        ),
        const Spacer(flex: 1),
        FilledButton(
          onPressed: onSubmitedPressed,
          child: const Text("Confirmar"),
        )
      ],
    );
  }
}
