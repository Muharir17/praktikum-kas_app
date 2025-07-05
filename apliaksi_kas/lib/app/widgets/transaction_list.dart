import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/transaction_model.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final RxList<TransactionModel> transactions;
  final bool isLoading;
  final Function(TransactionModel) onEdit;
  final Function(TransactionModel) onDelete;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.isLoading,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada transaksi',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tambahkan transaksi baru dengan tombol + di bawah',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      padding: const EdgeInsets.only(bottom: 80), // Add padding for FAB
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionItem(
          transaction: transaction,
          onEdit: onEdit,
          onDelete: onDelete,
        );
      },
    );
  }
}
