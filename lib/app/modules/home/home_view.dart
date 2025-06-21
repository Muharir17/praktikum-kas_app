import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../transaction/transaction_controller.dart';
import '../../data/models/transaction_model.dart';
import '../../widgets/modern_app_bar.dart';
import '../../widgets/summary_card.dart';
import '../auth/auth_controller.dart';
import '../../widgets/transaction_list.dart';
import '../../widgets/transaction_form.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();

    return Scaffold(
      appBar: ModernAppBar(
        title: 'Buku Kas',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final auth = Get.find<AuthController>();
              auth.logout();
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implementasi filter transaksi
              Get.snackbar(
                'Info',
                'Fitur filter akan segera hadir',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: Column(
          children: [
            SummaryCard(controller: transactionController),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.receipt_long, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Riwayat Transaksi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() => TransactionList(
                    transactions: transactionController.transactions,
                    isLoading: transactionController.isLoading.value,
                    onEdit: (transaction) =>
                        _showEditTransactionModal(context, transaction),
                    onDelete: (transaction) =>
                        _showDeleteConfirmation(context, transaction),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTransactionModal(context),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showAddTransactionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tambah Transaksi Baru',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TransactionForm(
                onSubmit: (transaction) {
                  final transactionController =
                      Get.find<TransactionController>();
                  transactionController.addTransaction(transaction);
                  Navigator.pop(context);
                  Get.snackbar(
                    'Sukses',
                    'Transaksi berhasil ditambahkan',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, TransactionModel transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Konfirmasi Hapus'),
        content: Text(
            'Apakah Anda yakin ingin menghapus transaksi "${transaction.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final transactionController = Get.find<TransactionController>();
              transactionController.deleteTransaction(transaction.id!);
              Navigator.pop(context);
              Get.snackbar(
                'Sukses',
                'Transaksi berhasil dihapus',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showEditTransactionModal(
      BuildContext context, TransactionModel transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Transaksi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TransactionForm(
                transaction: transaction,
                onSubmit: (updatedTransaction) {
                  final transactionController =
                      Get.find<TransactionController>();
                  transactionController.updateTransaction(updatedTransaction);
                  Navigator.pop(context);
                  Get.snackbar(
                    'Sukses',
                    'Transaksi berhasil diperbarui',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blue,
                    colorText: Colors.white,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
