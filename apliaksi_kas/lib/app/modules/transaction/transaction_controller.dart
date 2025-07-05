import 'package:aplikasi_kas/app/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class TransactionController extends GetxController {
  // final DBProvider dbProvider = DBProvider();

  var transactions = <TransactionModel>[].obs;
  var isLoading = true.obs;
  var totalIncome = 0.0.obs;
  var totalExpense = 0.0.obs;
  var balance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
    fetchSummary();
  }

  Future<void> fetchTransactions() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 800));
      transactions.value = _generateDummyTransactions();
    } catch (e) {
      debugPrint('Gagal Mengambil Data Transaksi: $e');
      Get.snackbar(
        'Error',
        'Gagal Memuat data transaksi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSummary() async {
    try {
      await Future.delayed(const Duration(seconds: 500));
      final summary = _calculateSummaryFromTransactions(transactions);
      totalIncome.value = summary['icome'] ?? 0.0;
      totalExpense.value = summary['expense'] ?? 0.0;
      balance.value = summary['balance'] ?? 0.0;
    } catch (e) {
      debugPrint('Gagal Mengambil Data Summary: $e');

      totalIncome.value = 0.0;
      totalExpense.value = 0.0;
      balance.value = 0.0;
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    transactions.add(transaction);
    await fetchSummary();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    final index = transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      transactions[index] = transaction;
    }
    await fetchSummary();
  }

  Future<void> deleteTransaction(int id) async {
    transactions.removeWhere((t) => t.id == id);
    await fetchSummary();
  }

  List<TransactionModel> _generateDummyTransactions() {
    final random = math.Random();
    final now = DateTime.now();
    final List<TransactionModel> dummyData = [];

    final incomeNames = [
      'Gaji',
      'Bonus',
      'Deviden',
      'Penjualan',
      'Hadiah',
      'Invenstasi'
    ];
    final expenseNames = [
      'Makan',
      'Minum',
      'Belanja',
      'Transportasi',
      'Hiburan',
      'Pendidikan',
      'Internet',
      'Pulsa'
    ];

    for (int i = 1; i <= 20; i++) {
      final bool isIncome = random.nextBool();
      final String title = isIncome
          ? incomeNames[random.nextInt(incomeNames.length)]
          : expenseNames[random.nextInt(expenseNames.length)];

      final double amount = (random.nextInt(50) + 1) * 10000.0;
      final DateTime date = now.subtract(
          Duration(days: random.nextInt(30), hours: random.nextInt(24)));

      dummyData.add(TransactionModel(
        id: i,
        title: title,
        amount: amount,
        date: date,
        type: isIncome ? 'income' : 'expense',
        description: 'Transaksi ${isIncome ? 'Pemasukan' : 'Pengeluaran'} #$i',
      ));
    }
    dummyData.sort((a, b) => b.date.compareTo(a.date));
    return dummyData;
  }

  Map<String, double> _calculateSummaryFromTransactions(
      List<TransactionModel> transactions) {
    double totalIncome = 0.0;
    double totalExpense = 0.0;
    for (final transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
      } else if (transaction.type == 'expense') {
        totalExpense += transaction.amount;
      }
    }
    return {
      'icome': totalIncome,
      'expense': totalExpense,
      'balance': totalIncome - totalExpense,
    };
  }
}
