import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stepx_task/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isDescriptionExpanded = false;

  void _shareProduct(BuildContext context) {
    final String shareText =
        'Check out this product: ${widget.product.title}\n\n'
        'Price: \$${widget.product.price}\n'
        'Description: ${widget.product.description}\n'
        'Rating: ${widget.product.rating}\n'
        'Stock: ${widget.product.stock}\n'
        'Link: ${widget.product.meta!.qrCode ?? ''}';

    Share.share(shareText, subject: "Check out this product");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? 'Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareProduct(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.product.thumbnail ?? '',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.title ?? 'No Title',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  widget.product.rating?.toStringAsFixed(1) ?? '0.0',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${widget.product.stock ?? 0} in stock)',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              initiallyExpanded: isDescriptionExpanded,
              onExpansionChanged: (expanded) {
                setState(() {
                  isDescriptionExpanded = expanded;
                });
              },
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.product.description ?? 'No description available',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Additional Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Brand: ${widget.product.brand ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Category: ${widget.product.category ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Warranty: ${widget.product.warrantyInformation ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
