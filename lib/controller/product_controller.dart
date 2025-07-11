// import 'package:get/get.dart';

// import '../features/auth/services/product_service.dart';
// import '../models/product.dart';

// class ProductController extends GetxController {
//   static ProductController instance = Get.find();
//   RxList<Product> productList = List<Product>.empty(growable: true).obs;
//   RxBool isProductLoading = false.obs;

//   @override
//   void onInit() {
//     getProducts();
//     super.onInit();
//   }

//   void getProducts() async {
//     try {
//       isProductLoading(true);
//       var result = await RemoteProductService().get();
//       if(result != null) {
//         productList.assignAll(productListFromJson(result.body))
//       }
//     } finally {
//       isProductLoading(false);
//       print(productList.length);
//     }
//   }
// }
