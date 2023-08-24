// ignore_for_file: deprecated_member_use

import '/provider/user.dart';
import '/screens/profile/profileupdate.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../utiles/profilemenu.dart';
import '../login/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimarycolor,
          title: const Text(
            'الحساب الشخصي',
          ),
        ),
        body: user.login == false
            ? Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    "رجاء قم بتسجيل الدخول او انشاء حساب",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset('assets/images/logo.png'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('اسم المستخدم',
                          style: Theme.of(context).textTheme.headline4),
                      Text('${user.userdata.name}',
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(height: 20),

                      /// -- BUTTON
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProfileScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimarycolor,
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            'تحديث البيانات',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),

                      /// -- MENU
                      ProfileMenuWidget(
                        title: "${user.userdata.phone}",
                        icon: LineAwesomeIcons.phone,
                        endIcon: false,
                        onPress: () {},
                      ),
                      const Divider(),
                      const SizedBox(height: 10),

                      ProfileMenuWidget(
                        title: "الخروج",
                        icon: LineAwesomeIcons.alternate_sign_out,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          user.logout(context);
                        },
                      ),
                      const Divider(),
                      const SizedBox(height: 10),

                      ProfileMenuWidget(
                        title: "حذف الحساب",
                        icon: LineAwesomeIcons.remove_user,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          user.del_account(context,user.userdata.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
