import 'package:carousel_slider/carousel_slider.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/frames/rounded_container.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/scaffold_widget/scaffold_widget.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SelectedAlbumPage extends StatelessWidget {
  const SelectedAlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => ScaffoldWidget(
            title: 'Album number #${state.albumIndex}',
            body: state.getPhotoInformationResList.isNotEmpty
                ? Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: state.getPhotoInformationResList.length,
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                        ),
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return RoundedContainer(
                            child: Image(
                                image: NetworkImage(state
                                    .getPhotoInformationResList[itemIndex]
                                    .url!)),
                          );
                        },
                      )
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2 - 20),
                    child: const Center(child: CircularProgressIndicator()),
                  )));
  }
}
