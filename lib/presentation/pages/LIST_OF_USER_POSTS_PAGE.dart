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

class ListOfUserPostsPage extends StatelessWidget {
  const ListOfUserPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => ScaffoldWidget(
              title:
                  'Список постов ${state.getUserInformationResList[state.userIndex].username}',
              body: Column(
                children: _customPostColumn(context, state),
              ),
            ));
  }
}

List<Widget> _customPostColumn(BuildContext context, AppState state) {
  List<GetPostsInformationRes> listOfPostsInfo =
      state.getPostsInformationResList;
  List<Widget> list = [];
  int length = 10;
  if (listOfPostsInfo.length < 10) {
    length = listOfPostsInfo.length;
  }
  for (int index = 0; index < length; index++) {
    list.add(InkWell(
      onTap: () async {
        if (state.postIndex != listOfPostsInfo[index].id) {
          appStore.dispatch(
              UpdateAppStateAction(getCommentsInformationResList: []));
          appStore.dispatch(
              UpdateAppStateAction(postIndex: listOfPostsInfo[index].id));

          await appStore.dispatch(GetCommentsByPostIdAction(
              postId: listOfPostsInfo[index].id!,
              routes: AppRoutes.selectedPostPage,
              context: context));
        } else {
          final UserSecurityStorage getUserInformationRes =
              UserSecurityStorage();
          var comments = await getUserInformationRes.readSecureData('comments');
          List<GetCommentsInformationRes> list = [];
          var res = json.decode(comments);
          for (int index = 0; index < res.length; index++) {
            list.add(GetCommentsInformationRes.fromJson(res[index]));
          }
          appStore.dispatch(
              UpdateAppStateAction(getCommentsInformationResList: list));
          Navigator.pushNamed(context, AppRoutes.selectedPostPage);
        }
      },
      child: RoundedContainer(
        child: Column(
          children: [
            CustomRow(
              left: "title",
              right: listOfPostsInfo[index].title!,
            ),
            const SizedBox(height: 10),
            CustomRow(
              left: 'post',
              right: listOfPostsInfo[index].body!,
            ),
          ],
        ),
      ),
    ));
  }
  return list;
}
