import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, mainAxisExtent: 135),
                          itemCount: 3,
                          itemBuilder: (context, i) => Container(
                            margin: const EdgeInsets.all(3),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: ItemCard(
                              product: app.cat1[i],
                              press: () {
                                shop.shop_by_cat(app.cat1[i].id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SubCat(
                                      name: app.cat1[i].name,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
        ],
      ),
    );
  }
}



class ItemCard extends StatelessWidget {
  final Datum product;
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
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black.withOpacity(0.04),
                    )),
                    child: Hero(
                      tag: "${product.id}",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: product.img,
                          fit: BoxFit.fill,
                          width: 100,
                          height: 90,
                          placeholder: (context, url) => Image.asset(
                            'asset/images/soon.png',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
