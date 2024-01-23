import 'package:aldy_project/app/data/enpoint/enpoint.dart';
import 'package:aldy_project/app/modules/book/controllers/book_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/_profider/dart/provider.dart';

class AddBookController extends GetxController {
  final loading = false.obs;
  final GlobalKey<FormState>formkey = GlobalKey<FormState>();
  final TextEditingController judilController = TextEditingController();
  final TextEditingController penulisdController = TextEditingController();
  final TextEditingController penerbitdController = TextEditingController();
  final TextEditingController tahunTerbitController = TextEditingController();
  final BookController bookController =Get.find();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  login() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formkey.currentState?.save();
      if (formkey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.book,
            data: {
                "judul":judilController.text.toString(),
                "penulis": penulisdController.text.toString(),
                "penerbit":  penerbitdController.text.toString(),
                "tahun_terbit": int.parse(tahunTerbitController.text.toString())
            });

        if (response.statusCode == 201) {
          bookController.getData();
          Get.back();
        } else {
          Get.snackbar("Sorry", "login gagal", backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        Get.snackbar("sorry", "${e.response?.data['messsage']}",
            backgroundColor: Colors.orange);
      }

      else {
        Get.snackbar("sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("eror", e.toString(), backgroundColor: Colors.red);
    }
  }
}
