// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmDialog({
  required BuildContext context,
  String title = 'Quitter RecycleApp',
  String content = 'Êtes-vous sûr de vouloir continuer ?',
  String confirmText = 'Oui',
  String cancelText = 'Non',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText),
            ),
          ],
        ),
  );
  return result ?? false;
}

// Future<bool> showExitConfirmationDialog(BuildContext context) async {
//   bool shouldExit = false;

//   await AwesomeDialog(
//     context: context,
//     dialogType: DialogType.warning,
//     animType: AnimType.bottomSlide,
//     title: 'Quitter l\'application ?',
//     desc: 'Voulez-vous vraiment quitter ?',
//     btnCancelText: 'Non',
//     btnOkText: 'Oui',
//     btnCancelOnPress: () {
//       shouldExit = false;
//     },
//     btnOkOnPress: () {
//       shouldExit = true;
//     },
//     dismissOnBackKeyPress: false,
//     dismissOnTouchOutside: false,
//   ).show();

//   return shouldExit;
// }
