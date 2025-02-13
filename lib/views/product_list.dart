import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stepx_task/models/product_model.dart';
import 'package:stepx_task/views/manager/product_cubit.dart';

class ProductListScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No products loaded yet')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (products) => SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                context.read<ProductCubit>().fetchProducts();
                _refreshController.refreshCompleted();
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItem(product: product);
                },
              ),
            ),
            error: (message) => Center(child: Text(message)),
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(product.thumbnail),
          Text(product.title),
          Text('\$${product.price}'),
        ],
      ),
    );
  }
}
