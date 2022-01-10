import 'package:eclipse_digital_test_task/presentation/widgets/hive_widgets/boxes.dart';
import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'package:eclipse_digital_test_task/data/utils/constants.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_style.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/frames/rounded_container.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/scaffold_widget/scaffold_widget.dart';
import 'package:eclipse_digital_test_task/redux/action.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ListOfUserAlbumsPage extends StatelessWidget {
  const ListOfUserAlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => ScaffoldWidget(
              title:
                  'Список альбомов ${state.getUserInformationResList[state.userIndex].username}',
              body: Column(
                children: _customAlbumColumn(context, state),
              ),
            ));
  }
}

List<Widget> _customAlbumColumn(BuildContext context, AppState state) {
  List<GetAlbumsInformationRes> listOfAlbumInfo =
      state.getAlbumsInformationResList;
  List<Widget> list = [];
  String thumbnailUrl = "https://via.placeholder.com/150/92c952";

  int length = 10;
  if (listOfAlbumInfo.length < 10) {
    length = listOfAlbumInfo.length;
  }
  for (int index = 0; index < length; index++) {
    list.add(RoundedContainer(
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              final photosBox = Boxes.getPhotosInformationRes();

              if (listOfAlbumInfo[index].id != state.albumIndex) {
                var object =
                    photosBox.get('albumnumber${state.userIndex} index');
                if (object == null) {
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
        ],
      ),
    ));
  }
  return list;
}
