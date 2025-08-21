import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recycleapp/widgets/re-use/fonction.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {'title': 'Gopay', 'amount': 'Rp12.000'},
      {'title': 'Blu', 'amount': 'Rp250.000'},
      {'title': 'Gopay', 'amount': 'Rp7.000'},
      {'title': 'Gopay', 'amount': 'Rp7.000'},
      {'title': 'Bank BCA', 'amount': 'Rp10.000'},
      {'title': 'Bank Mandiri', 'amount': 'Rp30.000'},
    ];

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => onWillPop(context, '/profile-view'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
          leading: BackButton(onPressed: () => context.go('/profile-view')),
        ),
        body: ListView.builder(
          itemCount: transactions.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final tx = transactions[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(tx['title']![0])),
                title: Text(tx['title']!),
                subtitle: const Text("Dec 12 2023 at 10:00 pm"),
                trailing: Text(
                  tx['amount']!,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
