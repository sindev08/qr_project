import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_project/app/controllers/auth_controller.dart';
import 'package:qr_project/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: GridView.builder(
          itemCount: 4,
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
          itemBuilder: (context, index) {
            late String title;
            late IconData icon;
            late VoidCallback onTap;

            switch (index) {
              case 0:
                title = "Add Product";
                icon = Icons.post_add_rounded;
                onTap = () => Get.toNamed(Routes.addProduct);
                break;
              case 1:
                title = "Products";
                icon = Icons.list_alt_outlined;
                onTap = () => Get.toNamed(Routes.products);
                break;
              case 2:
                title = "QR Code";
                icon = Icons.qr_code;
                onTap = () {
                  print("Open Camera");
                };
                break;
              case 3:
                title = "Catalog";
                icon = Icons.document_scanner_outlined;
                onTap = () {
                  controller.downloadCatalog();
                };
                break;
            }

            return Material(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(9),
              child: InkWell(
                onTap: onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      // color: Colors.red,
                      child: Icon(icon, size: 50),
                    ),
                    const SizedBox(height: 10),
                    Text(title)
                  ],
                ),
                // borderRadius: BorderRadius.circular(9),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> hasil = await authC.logout();
          if (hasil['error'] == false) {
            Get.offAllNamed(Routes.login);
          } else {
            Get.snackbar("Error", hasil["error"]);
          }
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
