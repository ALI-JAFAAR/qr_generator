import 'package:provider/provider.dart';
import '/provider/user.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    user.check_login(context);
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: BodyWidget(),
      ),
    );
  }
}
