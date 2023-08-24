import 'package:flutter/material.dart';
import '/constants.dart';

class Body extends StatelessWidget {

  const Body({Key? key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child:const  Column(
                    children: <Widget>[
                      SizedBox(height: kDefaultPaddin / 2),
                      SizedBox(height: kDefaultPaddin / 2),
                      
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
