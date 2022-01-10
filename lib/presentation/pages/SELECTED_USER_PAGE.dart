import 'dart:convert';

import 'package:eclipse_digital_test_task/data/storage/flutter_security_storage.dart';
import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'package:eclipse_digital_test_task/data/utils/constants.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_style.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/custom_rows/custom_row.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/frames/rounded_container.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/scaffold_widget/scaffold_widget.dart';
import 'package:eclipse_digital_test_task/redux/action.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SelectedUserPage extends StatelessWidget {
  const SelectedUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          GetUserInformationRes userInfo =
              state.getUserInformationResList[state.userIndex - 1];

          return ScaffoldWidget(
            body: state.getPostsInformationResList.isNotEmpty &&
                    state.getAlbumsInformationResList.isNotEmpty
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        RoundedContainer(
                          child: Column(
                            children: [
                              CustomRow(left: 'Name', right: userInfo.name!),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomRow(left: 'Email', right: userInfo.email!),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomRow(left: 'Phone', right: userInfo.phone!),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomRow(
                                  left: 'Website', right: userInfo.website!),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        RoundedContainer(
                          child: Column(
                            children: [
                              CustomRow(
                                  left: 'Company name ',
                                  right: userInfo.company!['name']),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomRow(
                                  left: 'Company bs ',
                                  right: userInfo.company!['bs']),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomRow(
                                left: 'Company catch phrase',
                                right: userInfo.company!['catchPhrase'],
                                rightTextStyle: ThemeTextStyle.R18blackItalic,
                              )
                            ],
                          ),
                        ),
                        // RoundedContainer(child: )
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _customListPostPreviewContainer(state, context),
                            _customListAlbumPreviewContainer(state, context),
                          ],
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2 - 20),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
            title: '${userInfo.username} page',
          );
        });
  }

  Widget _customListAlbumPreviewContainer(
      AppState state, BuildContext context) {
    List<GetAlbumsInformationRes> listOfAlbumInfo =
        state.getAlbumsInformationResList;
    String thumbnailUrl = "https://via.placeholder.com/150/92c952";
    return RoundedContainer(
      child: Column(
        children: [
          for (int index = 0; index < 3; index++)
            InkWell(
              onTap: () async {
                if (listOfAlbumInfo[index].id != state.albumIndex) {
                  await appStore.dispatch(GetPhotosByAlbumIdAction(
                      albumId: listOfAlbumInfo[index].id!,
                      routes: AppRoutes.selectedAlbumPage,
                      context: context));
                  appStore.dispatch(UpdateAppStateAction(
                      albumIndex: listOfAlbumInfo[index].id));
                } else {
                  final UserSecurityStorage getUserInformationRes =
                      UserSecurityStorage();
                  var photos =
                      await getUserInformationRes.readSecureData('photos');
                  List<GetPhotosInformationRes> list = [];
                  var res = json.decode(photos);
                  for (int index = 0; index < res.length; index++) {
                    list.add(GetPhotosInformationRes.fromJson(res[index]));
                  }
                  appStore.dispatch(
                      UpdateAppStateAction(getPhotoInformationResList: list));
                  Navigator.pushNamed(context, AppRoutes.selectedAlbumPage);
                }
              },
              child: Row(
                children: [
                  RoundedContainer(
                    paddings: EdgeInsets.zero,
                    child: Image(
                      image: NetworkImage(thumbnailUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      listOfAlbumInfo[index].title!,
                      style: ThemeTextStyle.R18black,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.listOfUserAlbumsPage);
            },
            child: const Text(
              'Посмотреть все альбомы',
              style: ThemeTextStyle.R18Linkblue,
            ),
          )
        ],
      ),
    );
  }
}

Widget _customListPostPreviewContainer(AppState state, BuildContext context) {
  List<GetPostsInformationRes> listOfPostsInfo =
      state.getPostsInformationResList;
  return RoundedContainer(
    child: Column(
      children: [
        for (int index = 0; index < 3; index++)
          Column(
            children: [
              RoundedContainer(
                margin: EdgeInsets.zero,
                child: InkWell(
                  onTap: () async {
                    if (state.postIndex != listOfPostsInfo[index].id) {
                      appStore.dispatch(UpdateAppStateAction(
                          getCommentsInformationResList: []));
                      appStore.dispatch(UpdateAppStateAction(
                          postIndex: listOfPostsInfo[index].id));

                      await appStore.dispatch(GetCommentsByPostIdAction(
                          postId: listOfPostsInfo[index].id!,
                          routes: AppRoutes.selectedPostPage,
                          context: context));
                    } else {
                      final UserSecurityStorage getUserInformationRes =
                          UserSecurityStorage();
                      var comments = await getUserInformationRes
                          .readSecureData('comments');
                      List<GetCommentsInformationRes> list = [];
                      var res = json.decode(comments);
                      for (int index = 0; index < res.length; index++) {
                        list.add(
                            GetCommentsInformationRes.fromJson(res[index]));
                      }
                      appStore.dispatch(UpdateAppStateAction(
                          getCommentsInformationResList: list));
                      Navigator.pushNamed(context, AppRoutes.selectedPostPage);
                    }
                  },
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
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.listOfUserPostsPage);
          },
          child: const Text(
            'Посмотреть все посты',
            style: ThemeTextStyle.R18Linkblue,
          ),
        )
      ],
    ),
  );
}
