import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constants.dart';
import '../../../models/cat.dart';

class ItemCard extends StatelessWidget {
  final Cats product;
  final VoidCallback press;
  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.04),

                      )
                    ),
                    child: Hero(
                      tag: "${product.id}",
                      child: CachedNetworkImage(
                        imageUrl: product.img,
                        fit: BoxFit.fill,
                        width: 100,
                        height: 90,
                        placeholder: (context, url) =>Lottie.asset(
                        'assets/lotti/loading.json',
                        fit: BoxFit.cover,
                      ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Text(
                  product.name,
                  style: const TextStyle(color: kTextLightColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
