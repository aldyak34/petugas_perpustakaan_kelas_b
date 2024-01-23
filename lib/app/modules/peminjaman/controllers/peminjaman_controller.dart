import 'package:aldy_project/app/data/_profider/dart/provider.dart';
import 'package:aldy_project/app/data/enpoint/enpoint.dart';
import 'package:aldy_project/app/modules/response_pinjam.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';




class PeminjamanController extends GetxController with StateMixin<List<DataPinjam>> {

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(Endpoint.pinjam,);

      if (response.statusCode == 200) {
        final ResponsePinjam responseBook = ResponsePinjam.fromJson(response.data);
        if (responseBook.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(responseBook.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("gagal mengambil data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(
              null,
              status: RxStatus.error("${e.response?.data['messsage']}"));
        }
      } else {
        change(null, status: RxStatus.error(" e.message ??"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}