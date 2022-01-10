import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eclipse_digital_test_task/data/storage/flutter_security_storage.dart';
import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/model/create_comment/create_comment_model_res.dart';
import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'package:eclipse_digital_test_task/data/utils/constants.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';
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
    final UserSecurityStorage userSecureStorage = UserSecurityStorage();
    List<GetUserInformationRes> object = [];
    final res = await _getClient().get(ApiQueries.queryGetUsers,
        options: Options(responseType: ResponseType.plain));
    var decoded = json.decode(res.data.toString());

    if (decoded.length > 0) {
      userSecureStorage.writeSecureData('users', res.data.toString());
      for (int index = 0; index < decoded.length; index++) {
        object.add(GetUserInformationRes.fromJson(decoded[index]));
      }
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
    Navigator.pushNamed(action.context, action.routes);

    final UserSecurityStorage userSecureStorage = UserSecurityStorage();

    List<GetCommentsInformationRes> object = [];
    final res = await _getClient().get(ApiQueries.queryGetComments,
        queryParameters: {"postId": action.postId},
        options: Options(responseType: ResponseType.plain));
    var decoded = json.decode(res.data.toString());

    if (decoded.length > 0) {
      userSecureStorage.writeSecureData('comments', res.data.toString());
      for (int index = 0; index < decoded.length; index++) {
        object.add(GetCommentsInformationRes.fromJson(decoded[index]));
      }
      next(UpdateAppStateAction(getCommentsInformationResList: object));
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
    final UserSecurityStorage userSecureStorage = UserSecurityStorage();

    // comments.add();
    final res = await _getClient().post(
      ApiQueries.queryGetComments,
      data: action.createCommentReq.toJson(),
    );
    var object = CreateCommentRes.fromJson(res.data);
    var lastComment = GetCommentsInformationRes(
      postId: state.postIndex,
      id: object.id,
      name: object.name,
      email: object.email,
      body: object.body,
    );
    final List<GetCommentsInformationRes> newCommentsList =
        state.getCommentsInformationResList;
    newCommentsList.add(lastComment);
    var comments = json.encode(newCommentsList);
    userSecureStorage.writeSecureData("comments", comments);
    next(UpdateAppStateAction(getCommentsInformationResList: newCommentsList));
    Navigator.pop(action.context);
  } on DioError catch (e) {
    _alert("Проблема с апи", e.error.toString(), action.context);
  }
}

_getPhotosByAlbumIdAction(AppState state, GetPhotosByAlbumIdAction action,
    NextDispatcher next) async {
  try {
    Navigator.pushNamed(action.context, action.routes);

    List<GetPhotosInformationRes> object = [];
    final UserSecurityStorage userSecureStorage = UserSecurityStorage();

    final res = await _getClient().get(ApiQueries.queryGetPhotos,
        options: Options(responseType: ResponseType.plain),
        queryParameters: {'albumId': action.albumId});
    var decoded = json.decode(res.data.toString());

    if (decoded.length > 0) {
      userSecureStorage.writeSecureData('photos', res.data.toString());
      for (int index = 0; index < decoded.length; index++) {
        object.add(GetPhotosInformationRes.fromJson(decoded[index]));
      }
      next(UpdateAppStateAction(
        getPhotoInformationResList: object,
      ));
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
    final UserSecurityStorage userSecureStorage = UserSecurityStorage();

    final res = await _getClient().get(ApiQueries.queryGetAlbums,
        options: Options(responseType: ResponseType.plain),
        queryParameters: {"userId": action.userId});

    final res2 = await _getClient().get(ApiQueries.queryGetPosts,
        options: Options(responseType: ResponseType.plain),
        queryParameters: {"userId": action.userId});
    var decoded = json.decode(res.data.toString());
    var decoded2 = json.decode(res2.data.toString());

    if (decoded.length > 0 && decoded2.length > 0) {
      userSecureStorage.writeSecureData('albums', res.data.toString());
      userSecureStorage.writeSecureData('posts', res2.data.toString());

      for (int index = 0; index < decoded.length; index++) {
        object.add(GetAlbumsInformationRes.fromJson(decoded[index]));
      }

      for (int index = 0; index < decoded2.length; index++) {
        object2.add(GetPostsInformationRes.fromJson(decoded2[index]));
      }

      next(UpdateAppStateAction(
          getAlbumsInformationResList: object,
          getPostsInformationResList: object2));
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
