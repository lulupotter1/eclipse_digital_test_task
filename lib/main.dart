import 'package:eclipse_digital_test_task/data/utils/constants.dart';
import 'package:eclipse_digital_test_task/presentation/pages/LIST_OF_USERS_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/LIST_OF_USER_ALBUMS_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/LIST_OF_USER_POSTS_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/SELECTED_ALBUM_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/SELECTED_POST_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/pages/SELECTED_USER_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/hive_widgets/boxes.dart';
import 'package:eclipse_digital_test_task/redux/action.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GetPostsInformationResAdapter());
  Hive.registerAdapter(GetAlbumsInformationResAdapter());
  Hive.registerAdapter(GetCommentsInformationResAdapter());
  Hive.registerAdapter(GetPhotosInformationResAdapter());
  Hive.registerAdapter(GetUserInformationResAdapter());

  await Hive.openBox<GetPostsInformationRes>('GetPostsInformationRes');
  await Hive.openBox<GetAlbumsInformationRes>('GetAlbumsInformationRes');
  await Hive.openBox<GetCommentsInformationRes>('GetCommentsInformationRes');
  await Hive.openBox<GetPhotosInformationRes>('GetPhotosInformationRes');
  await Hive.openBox<GetUserInformationRes>('GetUserInformationRes');

  runApp(TestApplication());
}

class TestApplication extends StatefulWidget {
  @override
  State<TestApplication> createState() => _TestApplicationState();
}

class _TestApplicationState extends State<TestApplication> {
  // bool checked = false;

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

  _checkHiveStorage() async {
    var usersBox = Boxes.getUserInformationRes();
    var object = usersBox.get(1);

    if (object == null) {
      await appStore.dispatch(GetUsersAction(context: context));
    } else {
      List<GetUserInformationRes> list = [];
      var a = usersBox.get(1);
      for (int index = 0; index < usersBox.keys.toList().length; index++) {
        if (usersBox.containsKey(index)) {
          list.add(usersBox.get(index)!);
        }
      }
      appStore.dispatch(UpdateAppStateAction(getUserInformationResList: list));
    }
  }
}
