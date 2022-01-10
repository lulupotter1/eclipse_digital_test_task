import 'package:eclipse_digital_test_task/data/storage/flutter_security_storage.dart';
import 'package:eclipse_digital_test_task/presentation/pages/LIST_OF_USERS_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/LIST_OF_USER_ALBUMS_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/LIST_OF_USER_POSTS_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/SELECTED_ALBUM_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/SELECTED_POST_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/SELECTED_USER_PAGE.dart';
import 'package:eclipse_digital_test_task/redux/action.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'dart:convert';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

main() {
  runApp(TestApplication());
}

class TestApplication extends StatefulWidget {
  @override
  State<TestApplication> createState() => _TestApplicationState();
}

class _TestApplicationState extends State<TestApplication> {
  @override
  void initState() {
    _checkHiveStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => StoreProvider(
          store: appStore,
          child: MaterialApp(
            title: 'Test Application',
            initialRoute: 'LIST_OF_USERS_PAGE',
            debugShowCheckedModeBanner: false,
            // theme: ThemeData.dark(),
            routes: {
              'LIST_OF_USERS_PAGE': (context) => const ListOfUsersPage(),
              'LIST_OF_USER_POSTS_PAGE': (context) =>
                  const ListOfUserPostsPage(),
              'LIST_OF_USER_ALBUMS_PAGE': (context) =>
                  const ListOfUserAlbumsPage(),
              'SELECTED_ALBUM_PAGE': (context) => const SelectedAlbumPage(),
              'SELECTED_POST_PAGE': (context) => const SelectedPostPage(),
              'SELECTED_USER_PAGE': (context) => const SelectedUserPage(),
            },
          )),
    );
  }

  Future _checkHiveStorage() async {
    final UserSecurityStorage getUserInformationRes = UserSecurityStorage();
    var object = await getUserInformationRes.readSecureData('users');
    // getUserInformationRes.deleteSecureData('users');
    if (object == null) {
      await appStore.dispatch(GetUsersAction(context: context));
    } else {
      List<GetUserInformationRes> list = [];
      var res = json.decode(object);
      for (int index = 0; index < res.length; index++) {
        list.add(GetUserInformationRes.fromJson(res[index]));
      }
      appStore.dispatch(UpdateAppStateAction(getUserInformationResList: list));
    }
  }
}
