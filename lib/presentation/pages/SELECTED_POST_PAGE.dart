import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/model/model_exporter.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_style.dart';
import 'package:eclipse_digital_test_task/presentation/pages/SEND_COMMENTS_PAGE.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/alert/show_body_dialog.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/buttons/expanded_button.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/custom_rows/custom_row.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/frames/rounded_container.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/scaffold_widget/scaffold_widget.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SelectedPostPage extends StatelessWidget {
  const SelectedPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => ScaffoldWidget(
            title: 'Детальная страница с комментами',
            body: state.getCommentsInformationResList.isNotEmpty
                ? Column(
                    children: listOfComments(
                        state.getCommentsInformationResList, context),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2 - 20),
                    child: const Center(child: CircularProgressIndicator()),
                  )));
  }
}

List<Widget> listOfComments(
    List<GetCommentsInformationRes> listOfComments, BuildContext context) {
  List<Widget> list = [];
  int length = 10;
  if (listOfComments.length < 10) {
    length = listOfComments.length;
  }
  for (int index = 0; index < length; index++) {
    list.add(RoundedContainer(
        child: Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRow(
              left: 'Name',
              right: listOfComments[index].name!,
            ),
            CustomRow(
              left: 'Email',
              right: listOfComments[index].email!,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "'${listOfComments[index].body}'",
          style: ThemeTextStyle.R18blackItalic,
        )
      ],
    )));
  }
  list.add(CustomButton(
    text: 'Добавить комментарий',
    onPressed: () async {
      await showPageDialog(context, titleText: '', body: SendCommentPage());
    },
  ));
  return list;
}
