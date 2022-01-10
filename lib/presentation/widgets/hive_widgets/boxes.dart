import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<GetUserInformationRes> getUserInformationRes() =>
      Hive.box<GetUserInformationRes>('GetUserInformationRes');

  static Box<GetPostsInformationRes> getPostsInformationRes() =>
      Hive.box<GetPostsInformationRes>('GetPostsInformationRes');

  static Box<GetAlbumsInformationRes> getAlbumsInformationRes() =>
      Hive.box<GetAlbumsInformationRes>('GetAlbumsInformationRes');

  static Box<GetCommentsInformationRes> getCommentsInformationRes() =>
      Hive.box<GetCommentsInformationRes>('GetCommentsInformationRes');

  static Box<GetPhotosInformationRes> getPhotosInformationRes() =>
      Hive.box<GetPhotosInformationRes>('GetPhotosInformationRes');
}
