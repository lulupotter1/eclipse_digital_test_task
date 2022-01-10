import 'package:eclipse_digital_test_task/presentation/widgets/hive_widgets/boxes.dart';
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
              state.getUserInformationResList[state.userIndex];

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
                final photosBox = Boxes.getPhotosInformationRes();

                if (listOfAlbumInfo[index].id != state.albumIndex) {
                  if (photosBox.get('albumnumber${state.userIndex} index') ==
                      null) {
                    await appStore.dispatch(GetPhotosByAlbumIdAction(
                        albumId: listOfAlbumInfo[index].id!,
                        routes: AppRoutes.selectedAlbumPage,
                        context: context));
                    appStore.dispatch(UpdateAppStateAction(
                        albumIndex: listOfAlbumInfo[index].id));
                  } else {
                    List<GetPhotosInformationRes> list = [];
                    for (int index = 0;
                        index < photosBox.keys.toList().length;
                        index++) {
                      if (photosBox.containsKey(index)) {
                        list.add(photosBox.get(index)!);
                      }
                    }
                    appStore.dispatch(
                        UpdateAppStateAction(getPhotoInformationResList: list));
                  }
                } else {
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
                    final commentsBox = Boxes.getCommentsInformationRes();

                    if (state.postIndex != listOfPostsInfo[index].id) {
                      if (commentsBox
                              .get('postnumber${state.userIndex} index') ==
                          null) {
                        appStore.dispatch(UpdateAppStateAction(
                            getCommentsInformationResList: []));
                        appStore.dispatch(UpdateAppStateAction(
                            postIndex: listOfPostsInfo[index].id));

                        await appStore.dispatch(GetCommentsByPostIdAction(
                            postId: listOfPostsInfo[index].id!,
                            routes: AppRoutes.selectedPostPage,
                            context: context));
                      } else {
                        List<GetCommentsInformationRes> list = [];
                        for (int index = 0;
                            index < commentsBox.keys.toList().length;
                            index++) {
                          if (commentsBox.containsKey(index)) {
                            list.add(commentsBox.get(index)!);
                          }
                        }
                        appStore.dispatch(UpdateAppStateAction(
                            getCommentsInformationResList: list));
                      }
                    } else {
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
