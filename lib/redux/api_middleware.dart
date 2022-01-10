import 'package:dio/dio.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/hive_widgets/boxes.dart';
import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/model/create_comment/create_comment_model_res.dart';
import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'package:eclipse_digital_test_task/data/utils/constants.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:redux/redux.dart';

import 'action.dart';

class ApiMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    switch (action.runtimeType) {
      case GetUsersAction:
        return _getUsersAction(store.state, action, next);
      case GetCommentsByPostIdAction:
        return _getCommentsByPostIdAction(store.state, action, next);
      case CreateCommentAction:
        return _createCommentAction(store.state, action, next);
      case GetPhotosByAlbumIdAction:
        return _getPhotosByAlbumIdAction(store.state, action, next);
      case GetPostsAndAlbumsByUserIdACtion:
        return _getPostsAndAlbumsByUserIdACtion(store.state, action, next);

      default:
        return next(action);
    }
  }
}

_getUsersAction(
    AppState state, GetUsersAction action, NextDispatcher next) async {
  try {
    final usersBox = Boxes.getUserInformationRes();

    List<GetUserInformationRes> object = [];
    final res = await _getClient().get(ApiQueries.queryGetUsers);
    if (res.data.length > 0) {
      for (int index = 0; index < res.data.length; index++) {
        object.add(GetUserInformationRes.fromJson(res.data[index]));
        GetUserInformationRes getUserInformationRes = GetUserInformationRes();

        getUserInformationRes.id = object[index].id;
        getUserInformationRes.name = object[index].name;
        getUserInformationRes.email = object[index].email;
        getUserInformationRes.username = object[index].username;
        getUserInformationRes.adress = object[index].adress;
        getUserInformationRes.phone = object[index].phone;
        getUserInformationRes.website = object[index].website;
        getUserInformationRes.company = object[index].company;
        usersBox.put(index, getUserInformationRes);
        getUserInformationRes.save();
      }

      var a = usersBox.get(1);
      next(UpdateAppStateAction(getUserInformationResList: object));
    } else {
      _alert("Проблема с апи", "Попробуйте еще раз", action.context);
    }
  } on DioError catch (e) {
    _alert("Проблема с апи", e.error.toString(), action.context);
  }
}

_getCommentsByPostIdAction(AppState state, GetCommentsByPostIdAction action,
    NextDispatcher next) async {
  try {
    List<GetCommentsInformationRes> object = [];
    Navigator.pushNamed(action.context, action.routes);
    final commentsBox = Boxes.getCommentsInformationRes();
    final res = await _getClient().get(ApiQueries.queryGetComments,
        queryParameters: {"userId": action.postId});
    if (res.data.length > 0) {
      for (int index = 0; index < res.data.length; index++) {
        object.add(GetCommentsInformationRes.fromJson(res.data[index]));

        commentsBox.put('postnumber${state.userIndex} index',
            GetCommentsInformationRes.fromJson(res.data[index]));
      }

      next(UpdateAppStateAction(getCommentsInformationResList: object));

      // final commentsInfo =
      //     HiveModelCustom(getCommentsInformationResList: object);

      // commentsBox.put('GetCommentsInformationRes', commentsInfo);
    } else {
      _alert("Проблема с апи", "Попробуйте еще раз", action.context);
    }
  } on DioError catch (e) {
    _alert("Проблема с апи", e.error.toString(), action.context);
  }
}

_createCommentAction(
    AppState state, CreateCommentAction action, NextDispatcher next) async {
  try {
    final commentsBox = Boxes.getCommentsInformationRes();

    final res = await _getClient().post(ApiQueries.queryGetComments,
        data: action.createCommentReq.toJson());
    var object = CreateCommentRes.fromJson(res.data);

    final List<GetCommentsInformationRes> newCommentsList =
        state.getCommentsInformationResList;
    newCommentsList.add(GetCommentsInformationRes(
      postId: state.postIndex,
      id: object.id,
      name: object.name,
      email: object.email,
      body: object.body,
    ));

    commentsBox.add(GetCommentsInformationRes(
      postId: state.postIndex,
      id: object.id,
      name: object.name,
      email: object.email,
      body: object.body,
    ));

    next(UpdateAppStateAction(getCommentsInformationResList: newCommentsList));

    // final commentsInfo = HiveModelCustom(
    //     getCommentsInformationResList: state.getCommentsInformationResList);

    // commentsBox.put('GetCommentsInformationRes', commentsInfo);
  } on DioError catch (e) {
    _alert("Проблема с апи", e.error.toString(), action.context);
  }
}

_getPhotosByAlbumIdAction(AppState state, GetPhotosByAlbumIdAction action,
    NextDispatcher next) async {
  try {
    List<GetPhotosInformationRes> object = [];
    Navigator.pushNamed(action.context, action.routes);
    final photosBox = Boxes.getPhotosInformationRes();

    final res = await _getClient().get(ApiQueries.queryGetPhotos,
        queryParameters: {'albumId': action.albumId});
    if (res.data.length > 0) {
      for (int index = 0; index < res.data.length; index++) {
        object.add(GetPhotosInformationRes.fromJson(res.data[index]));

        photosBox.put('albumnumber${state.userIndex} index',
            GetPhotosInformationRes.fromJson(res.data[index]));
      }
      next(UpdateAppStateAction(
        getPhotoInformationResList: object,
      ));

      // final photosInfo = HiveModelCustom(getPhotosInformationResList: object);
      // photosBox.put('GetPhotosInformationRes', photosInfo);
    } else {
      _alert("Проблема с апи", "Попробуйте еще раз", action.context);
    }
  } on DioError catch (e) {
    _alert("Проблема с апи", e.error.toString(), action.context);
  }
}

_getPostsAndAlbumsByUserIdACtion(AppState state,
    GetPostsAndAlbumsByUserIdACtion action, NextDispatcher next) async {
  List<GetPostsInformationRes> object2 = [];
  List<GetAlbumsInformationRes> object = [];
  try {
    Navigator.pushNamed(action.context, action.routes);
    final postsBox = Boxes.getPostsInformationRes();
    final albumsBox = Boxes.getAlbumsInformationRes();

    final res = await _getClient().get(ApiQueries.queryGetAlbums,
        queryParameters: {"userId": action.userId});

    final res2 = await _getClient().get(ApiQueries.queryGetPosts,
        queryParameters: {"userId": action.userId});

    if (res.data.length > 0 && res2.data.length > 0) {
      for (int index = 0; index < res.data.length; index++) {
        object.add(GetAlbumsInformationRes.fromJson(res.data[index]));
        object2.add(GetPostsInformationRes.fromJson(res2.data[index]));
        postsBox.put(
          'usernumber${state.userIndex} index',
          GetPostsInformationRes.fromJson(res2.data[index]),
        );

        albumsBox.put('usernumber${state.userIndex} index',
            GetAlbumsInformationRes.fromJson(res.data[index]));
      }

      next(UpdateAppStateAction(
          getAlbumsInformationResList: object,
          getPostsInformationResList: object2));

      // final albumsInfo = HiveModelCustom(getAlbumsInformationResList: object);
      // final postsInfo = HiveModelCustom(getPostsInformationResList: object2);
      // albumsBox.put('GetAlbumsInformationRes', albumsInfo);
      // albumsBox.put('GetPostsInformationRes', postsInfo);

      Navigator.pushNamed(action.context, action.routes);
    } else {
      _alert("Проблема с апи", "Попробуйте еще раз", action.context);
    }
  } on DioError catch (e) {
    _alert("Проблема с апи", e.error.toString(), action.context);
  }
}

Dio _getClient({
  String? contentType,
  Map<String, dynamic>? queryParameters,
  String? additionalUrl,
}) {
  return ApiClient(
          additionalUrl: additionalUrl,
          queryParameters: queryParameters,
          contentType: contentType)
      .init();
}

class ApiClient {
  String? contentType;
  String? additionalUrl;
  Map<String, dynamic>? queryParameters;

  ApiClient({this.queryParameters, this.contentType, this.additionalUrl});

  Map<String, dynamic>? get headers {
    return {"Content-Type": contentType ?? "application/json"};
  }

  Dio init() {
    Dio _dio = Dio();

    BaseOptions options = BaseOptions(
      baseUrl: additionalUrl ?? Constants.restBaseUrl,
      headers: headers,
      queryParameters: queryParameters,
    );
    _dio.options = options;
    return _dio;
  }
}

class ApiQueries {
  static const String queryGetUsers = "users";
  static const String queryGetPosts = "posts";
  static const String queryGetAlbums = "albums";
  static const String queryGetComments = "comments";
  static const String queryGetPhotos = "photos";
}

void _alert(String title, String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text('Хорошо'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );
}
