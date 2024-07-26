import 'package:booking_hotel/class/dialog_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  
  @override 
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) async {
    // Kiểm tra tất cả các kết quả trong danh sách
    bool isDisconnected = connectivityResults.contains(ConnectivityResult.none);

    if (isDisconnected) {
      DialogHelper.showNoInternetDialog();
    } else {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }
}
