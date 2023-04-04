import 'package:flutter/material.dart';
import 'package:pokedex_app_flutter/core/constants.dart';

class SnackBarService {
 

  void showGenericErrorSnackBar(BuildContext context, [String? text]) {
    showSnackBar(
      context,
      text ?? kGenericErrorMessage,
      Icon(Icons.error_outline, color: Theme.of(context).colorScheme.background),
      textColor: Theme.of(context).colorScheme.background,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
    );
  }

  void showSnackBar(BuildContext context, String text, Icon icon, {Color? backgroundColor, Color? textColor}) {
    if (text.isNotEmpty) {
      final SnackBar snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.background,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 12),
            Flexible(child: Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor ?? Theme.of(context).colorScheme.onBackground))),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
