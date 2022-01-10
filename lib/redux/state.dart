import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'package:eclipse_digital_test_task/redux/reducer.dart';
import 'package:redux/redux.dart';

import 'api_middleware.dart';

final appStore = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    ApiMiddleware(),
  ],
);

class AppState {
  final List<GetAlbumsInformationRes> getAlbumsInformationResList;
  final List<GetCommentsInformationRes> getCommentsInformationResList;
  final List<GetPostsInformationRes> getPostsInformationResList;
  final List<GetUserInformationRes> getUserInformationResList;
  final List<GetPhotosInformationRes> getPhotoInformationResList;
  //for saving what exactly index was selected
  final int userIndex;
  final int postIndex;
  final int albumIndex;

  AppState({
    required this.getAlbumsInformationResList,
    required this.getCommentsInformationResList,
    required this.getPostsInformationResList,
    required this.getUserInformationResList,
    required this.getPhotoInformationResList,
    required this.userIndex,
    required this.postIndex,
    required this.albumIndex,
  });

  factory AppState.initial() {
    return AppState(
      getAlbumsInformationResList: [],
      getCommentsInformationResList: [],
      getPostsInformationResList: [],
      getUserInformationResList: [],
      getPhotoInformationResList: [],
      userIndex: -1,
      postIndex: -1,
      albumIndex: -1,
    );
  }

  AppState copyWith({
    List<GetAlbumsInformationRes>? getAlbumsInformationResList,
    List<GetCommentsInformationRes>? getCommentsInformationResList,
    List<GetPostsInformationRes>? getPostsInformationResList,
    List<GetUserInformationRes>? getUserInformationResList,
    List<GetPhotosInformationRes>? getPhotoInformationResList,
    int? userIndex,
    int? postIndex,
    int? albumIndex,
  }) {
    return AppState(
      getAlbumsInformationResList:
          getAlbumsInformationResList ?? this.getAlbumsInformationResList,
      getCommentsInformationResList:
          getCommentsInformationResList ?? this.getCommentsInformationResList,
      getPostsInformationResList:
          getPostsInformationResList ?? this.getPostsInformationResList,
      getUserInformationResList:
          getUserInformationResList ?? this.getUserInformationResList,
      getPhotoInformationResList:
          getPhotoInformationResList ?? this.getPhotoInformationResList,
      userIndex: userIndex ?? this.userIndex,
      postIndex: postIndex ?? this.postIndex,
      albumIndex: albumIndex ?? this.albumIndex,
    );
  }
}
