import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../models/product.dart';

import '../../../constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
          ),
          // SizedBox(height: kDefaultPaddin-20),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "${product.price} د.ع",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Hero(
                  tag: "${product.id}",
                  child: CachedNetworkImage(
                    imageUrl: product.img,
                    height: 160,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Lottie.asset(
                      'assets/lotti/loading.json',
                      fit: BoxFit.fill,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  //     Image.network(
                  //   product.img,
                  //   fit: BoxFit.fill,
                  // ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
