import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_book_controller.dart';

class AddBookView extends GetView<AddBookController> {
  const AddBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddBookView'),
        centerTitle: true,
      ),
       body:  Center(
    child: Form(
    key: controller.formkey,
        child:Column(
          children: [
            TextFormField(
              controller: controller.judilController,
              decoration: InputDecoration(hintText: "Masukan judul"),
              validator: (value){
                if(value!.length<2){
                  return "judul tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.penulisdController,
              decoration: InputDecoration(hintText: "Masukan penulis"),
              validator: (value){
                if(value!.length<6){
                  return "Penulis tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.penerbitdController,
              decoration: InputDecoration(hintText: "Masukan penerbit"),
              validator: (value){
                if(value!.length<6){
                  return "Penerbit tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.tahunTerbitController,
              decoration: InputDecoration(hintText: "Masukan tahun terbit"),
              validator: (value){
                if(value!.length<6){
                  return "tahun terbit tidak boleh kosong";
                }
                return null;
              },
            ),
            Obx(() =>controller.loading.value?
            CircularProgressIndicator():
            ElevatedButton(onPressed: (){
              controller.login();
            },child: Text("Tambah"))
            )
          ],
        )
    ),
    ),
    );
}
}
