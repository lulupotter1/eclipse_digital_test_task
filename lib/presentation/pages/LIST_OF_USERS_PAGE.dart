import 'dart:convert';

import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'package:eclipse_digital_test_task/data/storage/flutter_security_storage.dart';
import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/utils/constants.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/custom_rows/custom_row.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/frames/rounded_container.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/scaffold_widget/scaffold_widget.dart';
import 'package:eclipse_digital_test_task/redux/action.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ListOfUsersPage extends StatelessWidget {
  const ListOfUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => ScaffoldWidget(
              title: 'Users list page',
              body: state.getUserInformationResList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: _usersInformation(state, context),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2 - 20),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
            ));
  }
}

List<Widget> _usersInformation(AppState state, BuildContext context) {
  List<GetUserInformationRes> usersList = state.getUserInformationResList;
  List<Widget> list = [];
  for (int index = 0; index < usersList.length; index++) {
    list.add(GestureDetector(
      onTap: () async {
        if (state.userIndex != usersList[index].id) {
          appStore
              .dispatch(UpdateAppStateAction(getAlbumsInformationResList: []));
          appStore
              .dispatch(UpdateAppStateAction(getPostsInformationResList: []));

          appStore
              .dispatch(UpdateAppStateAction(userIndex: usersList[index].id));
          await appStore.dispatch(GetPostsAndAlbumsByUserIdACtion(
              userId: usersList[index].id!,
              routes: AppRoutes.selectedUserPage,
              context: context));
        } else {
          final UserSecurityStorage getUserInformationRes =
              UserSecurityStorage();
          var posts = await getUserInformationRes.readSecureData('posts');
          var albums = await getUserInformationRes.readSecureData('albums');
          List<GetPostsInformationRes> list = [];
          List<GetAlbumsInformationRes> list2 = [];
          var res = json.decode(posts);
          var res2 = json.decode(albums);
          for (int index = 0; index < res.length; index++) {
            list.add(GetPostsInformationRes.fromJson(res[index]));
          }
          for (int index = 0; index < res2.length; index++) {
            list2.add(GetAlbumsInformationRes.fromJson(res2[index]));
          }
          appStore.dispatch(UpdateAppStateAction(
              getPostsInformationResList: list,
              getAlbumsInformationResList: list2));
          Navigator.pushNamed(context, AppRoutes.selectedUserPage);
        }
      },
      child: RoundedContainer(
        child: Column(
          children: [
            CustomRow(left: 'Name', right: usersList[index].name!),
            const SizedBox(
              height: 10,
            ),
            CustomRow(left: 'Username', right: usersList[index].username!),
          ],
        ),
      ),
    ));
  }
  return list;
}
