import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stepx_task/models/product_model.dart';
import 'package:stepx_task/services/repo/product_repo.dart';

part 'product_cubit.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = ProductInitial;
  const factory ProductState.loading() = ProductLoading;
  const factory ProductState.loaded(List<ProductModel>? products) =
      ProductLoaded;
  const factory ProductState.error(String message) = ProductError;
}

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState.initial()) {
    fetchProducts();
  }
  ProductRepo repo = ProductRepo();

  List<ProductModel>? _products;
  List<ProductModel>? get products => _products ?? [];

  Future<void> fetchProducts() async {
    emit(const ProductState.loading());

    _products = await repo.fetchAllProducts();
    if (_products != null) {
      emit(ProductState.loaded(_products));
    } else {
      emit(const ProductState.error('Failed to load products'));
    }
  }
}
