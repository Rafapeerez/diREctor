import 'package:flutter/material.dart';

class SubmitAndCancelButtons extends StatelessWidget {
  final VoidCallback? onCancelPressed;
  final VoidCallback? onSubmitedPressed;
  final bool isLoading;

  const SubmitAndCancelButtons({
    super.key, 
    required this.onCancelPressed, 
    required this.onSubmitedPressed,
    this.isLoading = false
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
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('Enviar'),
        ),
      ],
    );
  }
}
