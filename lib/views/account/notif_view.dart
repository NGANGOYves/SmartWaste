// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recycleapp/theme.dart';
import 'package:recycleapp/widgets/buttons/custom_button.dart';
import 'package:recycleapp/widgets/re-use/fonction.dart';
import 'package:recycleapp/widgets/user/section_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  bool generalNotifications = true;
  bool orderNotifications = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      generalNotifications = prefs.getBool('generalNotifications') ?? true;
      orderNotifications = prefs.getBool('orderNotifications') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('generalNotifications', generalNotifications);
    await prefs.setBool('orderNotifications', orderNotifications);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context, '/profile-view'),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Notifications'),
          leading: BackButton(onPressed: () => context.go('/profile-view')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SwitchTileCard(
                title: 'Notifications générales',
                subtitle:
                    'Recevez des nouvelles générales, des annonces et des mises à jour de l’application.',
                value: generalNotifications,
                onChanged: (val) {
                  setState(() => generalNotifications = val);
                },
              ),
              SwitchTileCard(
                title: 'Notifications de collecte',
                subtitle:
                    'Soyez informé(e) à chaque fois qu’une demande de collecte est acceptée, refusée ou mise à jour.',
                value: orderNotifications,
                onChanged: (val) {
                  setState(() => orderNotifications = val);
                },
              ),
              const Spacer(),
              GradientButton(
                text: 'Sauvegarder les paramètres',
                onPressed: () async {
                  await _savePreferences();
                  context.go('/profile-view');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
