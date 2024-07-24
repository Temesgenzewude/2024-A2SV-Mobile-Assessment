import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product/product.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 226, 225, 225),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 41, 41, 41),
              offset: Offset(0, 2),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: GridTile(
          footer: Container(
           
            decoration: BoxDecoration( color: Colors.black87,
            borderRadius: BorderRadius.circular(10)),
        
        
            child: GridTileBar(
              // backgroundColor: Colors.black87,
              title: Text(
                product.title!,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 50),
            
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
        ),
      ),
    );
  }
}
