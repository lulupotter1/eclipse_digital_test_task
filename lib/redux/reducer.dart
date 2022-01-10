import 'package:eclipse_digital_test_task/redux/state.dart';

AppState appReducer(AppState state, dynamic action) {
  return state.copyWith(
    getAlbumsInformationResList:
        action.getAlbumsInformationResList ?? state.getAlbumsInformationResList,
    getCommentsInformationResList: action.getCommentsInformationResList ??
        state.getCommentsInformationResList,
    getPostsInformationResList:
        action.getPostsInformationResList ?? state.getPostsInformationResList,
    getUserInformationResList:
        action.getUserInformationResList ?? state.getUserInformationResList,
    getPhotoInformationResList:
        action.getPhotoInformationResList ?? state.getPhotoInformationResList,
    userIndex: action.userIndex ?? state.userIndex,
    postIndex: action.postIndex ?? state.postIndex,
    albumIndex: action.albumIndex ?? state.albumIndex,
  );
}
