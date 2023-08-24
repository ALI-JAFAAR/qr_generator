import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/constants.dart';
import '../../models/product.dart';
import '/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // each product have a color
        backgroundColor: kPrimarycolor,
        appBar: buildAppBar(context),
        body: const Body(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimarycolor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg"),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
