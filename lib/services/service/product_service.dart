import 'package:stepx_task/models/product_model.dart';
import 'package:stepx_task/services/dio_client.dart';
import 'package:stepx_task/utils/widgets/app_flutter_toast.dart';

class ProductService {
  final DioClient dioClient;

  ProductService(this.dioClient);

  Future<List<ProductModel>?> fetchAllProducts() async {
    try {
      final res = await dioClient.dio.get('/products');
      if (res.statusCode == 200) {
        final products = ProductModel.fromJsonList(res.data['products']);
        return products;
      }
    } catch (e) {
      print(e);
      AppFlutterToast.flutterToastError('Couldn\'t fetch Products');
      return null;
    }
    return null;
  }
}
