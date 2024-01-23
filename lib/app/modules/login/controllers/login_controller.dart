import 'dart:developer';

import 'package:aldy_project/app/data/_profider/dart/provider.dart';
import 'package:aldy_project/app/data/enpoint/enpoint.dart';
import 'package:aldy_project/app/data/storage/storage.dart';
import 'package:aldy_project/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class LoginController extends GetxController {
  final loading = false.obs;
  final GlobalKey<FormState>formkey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //TODO: Implement LoginController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    String status = StorageProvider.read(StorageKey.status);
    log("status :$status");
    if (status == "logged") {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  login() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formkey.currentState?.save();
      if (formkey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data: dio.FormData.fromMap(
                {
                  "username": usernameController.text.toString(),
                  "password": passwordController.text.toString()
                }));

        if (response.statusCode == 200) {
          await StorageProvider.write(StorageKey.status, "logged");
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar("Sorry", "login gagal", backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
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
