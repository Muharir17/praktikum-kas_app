import 'package:aplikasi_kas/app/modules/transaction/transaction_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TransactionController transactionController =
      Get.find<TransactionController>();

  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (!Get.isRegistered<TransactionController>()) {
      Get.put(TransactionController());
    }
  }

  void changeDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> RefreshData() async {
    await transactionController.fetchTransactions();
    await transactionController.fetchSummary();
  }
}
