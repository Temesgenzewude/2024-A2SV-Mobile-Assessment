import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/cart.dart';
import 'package:provider/provider.dart';
import '../models/product/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(product.title!),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              child: CachedNetworkImage(
                imageUrl: product.image!,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.orange[900],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Getting item image",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Average Rating: ${product.rating?.rate.toString() ?? '0.0'}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 44, 44, 44),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Total Reviews: ${product.rating?.count.toString() ?? '0'}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 44, 44, 44),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Text(
            //   '\$${product.price}',
            //   style: const TextStyle(
            //     color: Colors.grey,
            //     fontSize: 20,
            //   ),
            // ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                product.description!,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.start,
                softWrap: true,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '\$',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 73, 72, 72),
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(
                              text: product.price.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 7, 7, 7),
                                fontSize: 24,
                              ))
                        ]),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cart.addItem(product: product);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 6, 6, 6)!,
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Total items in the cart: ${cart.itemCount}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
