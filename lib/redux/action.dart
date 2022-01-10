//API actions

import 'package:flutter/cupertino.dart';
import 'package:eclipse_digital_test_task/data/model/create_comment/create_comment_model_req.dart';
import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';

class GetUsersAction {
  BuildContext context;
  GetUsersAction({required this.context});
}

class GetPostsByUserIdAction {
  BuildContext context;
  int userId;
  String routes;
  GetPostsByUserIdAction(
      {required this.userId, required this.routes, required this.context});
}

class GetPostsAndAlbumsByUserIdACtion {
  BuildContext context;
  String routes;
  int userId;
  GetPostsAndAlbumsByUserIdACtion(
      {required this.userId, required this.routes, required this.context});
}

class GetAlbumsByUserIdAction {
  BuildContext context;
  String routes;
  int userId;
  GetAlbumsByUserIdAction(
      {required this.userId, required this.routes, required this.context});
}

class GetCommentsByPostIdAction {
  BuildContext context;
  String routes;
  int postId;
  GetCommentsByPostIdAction(
      {required this.postId, required this.routes, required this.context});
}

class GetPhotosByAlbumIdAction {
  BuildContext context;

  String routes;
  int albumId;
  GetPhotosByAlbumIdAction(
      {required this.albumId, required this.routes, required this.context});
}

class CreateCommentAction {
  BuildContext context;

  CreateCommentReq createCommentReq;
  CreateCommentAction({required this.createCommentReq, required this.context});
}

class UpdateAppStateAction {
  String? clientError; //if server sends error
  List<GetAlbumsInformationRes>? getAlbumsInformationResList;
  List<GetCommentsInformationRes>? getCommentsInformationResList;
  List<GetPostsInformationRes>? getPostsInformationResList;
  List<GetUserInformationRes>? getUserInformationResList;
  List<GetPhotosInformationRes>? getPhotoInformationResList;
  int? userIndex;
  int? postIndex;
  int? albumIndex;

  UpdateAppStateAction({
    this.getAlbumsInformationResList,
    this.getCommentsInformationResList,
    this.getPostsInformationResList,
    this.getUserInformationResList,
    this.getPhotoInformationResList,
    this.albumIndex,
    this.postIndex,
    this.userIndex,
  });
}



//End of API actions.