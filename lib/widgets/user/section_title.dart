import 'package:flutter/material.dart';
import 'package:recycleapp/theme.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final Widget? leading;

  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading:
            leading ??
            const CircleAvatar(child: Icon(Icons.account_balance_wallet)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(
          amount,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SwitchTileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchTileCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: SwitchListTile(
        activeColor: AppColors.primary,
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
