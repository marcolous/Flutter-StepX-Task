import 'package:stepx_task/models/product_model.dart';
import 'package:stepx_task/services/dio_client.dart';
import 'package:stepx_task/services/service/product_service.dart';

class ProductRepo {
  ProductService service = ProductService(DioClient());

  Future<List<ProductModel>?> fetchAllProducts() async {
    return await service.fetchAllProducts();
  }
}
