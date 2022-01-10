import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/hive_widgets/boxes.dart';
import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/model/get_user_information/user_information_model_res.dart';
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
        final postsBox = Boxes.getPostsInformationRes();
        final albumsBox = Boxes.getAlbumsInformationRes();

        if (state.userIndex != usersList[index].id) {
          var post = postsBox.get('usernumber${state.userIndex} index');
          var album = albumsBox.get('usernumber${state.userIndex} index');
          if (post == null && album == null) {
            appStore.dispatch(
                UpdateAppStateAction(getAlbumsInformationResList: []));
            appStore
                .dispatch(UpdateAppStateAction(getPostsInformationResList: []));

            appStore
                .dispatch(UpdateAppStateAction(userIndex: usersList[index].id));
            await appStore.dispatch(GetPostsAndAlbumsByUserIdACtion(
                userId: usersList[index].id!,
                routes: AppRoutes.selectedUserPage,
                context: context));
          } else {
            List<GetPostsInformationRes> list = [];
            List<GetAlbumsInformationRes> list2 = [];
            for (int index = 0;
                index < postsBox.keys.toList().length;
                index++) {
              if (postsBox.containsKey(index)) {
                list.add(postsBox.get(index)!);
              }
            }

            for (int index = 0;
                index < albumsBox.keys.toList().length;
                index++) {
              if (albumsBox.containsKey(index)) {
                list2.add(albumsBox.get(index)!);
              }
            }

            appStore.dispatch(UpdateAppStateAction(
                getAlbumsInformationResList: list2,
                getPostsInformationResList: list));
            Navigator.pushNamed(context, AppRoutes.selectedUserPage);
          }
        } else {
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
