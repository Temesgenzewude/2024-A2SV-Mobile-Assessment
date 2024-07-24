import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function removeItem;

  const CartItemWidget(
      {super.key, required this.cartItem, required this.removeItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).indicatorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        removeItem(cartItem.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                    child: CachedNetworkImage(
                  imageUrl: cartItem.imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text('Total: \$${cartItem.price * cartItem.quantity}'),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${cartItem.quantity} x'),
                IconButton(
                    onPressed: () {
                      cartProvider.removeItem(cartItem.id);
                    },
                    icon: const Icon(Icons.delete_forever, size: 16,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
