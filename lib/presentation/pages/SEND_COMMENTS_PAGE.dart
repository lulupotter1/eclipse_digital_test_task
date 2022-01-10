import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/model/create_comment/create_comment_model_req.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/buttons/expanded_button.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/frames/rounded_container.dart';
import 'package:eclipse_digital_test_task/presentation/widgets/inputs/basic_input.dart';
import 'package:eclipse_digital_test_task/redux/action.dart';
import 'package:eclipse_digital_test_task/redux/state.dart';

class SendCommentPage extends StatelessWidget {
  SendCommentPage({Key? key}) : super(key: key);
  GlobalKey<FormState> formAuthKey13 = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formAuthKey13,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            BasicInput(
              controller: nameController,
            ),
            const SizedBox(
              height: 15,
            ),
            BasicInput(
              controller: emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            BasicInput(
              controller: commentController,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              text: 'Отправить',
              onPressed: () async {
                if (formAuthKey13.currentState!.validate()) {
                  await appStore.dispatch(CreateCommentAction(
                      context: context,
                      createCommentReq: CreateCommentReq(
                          body: commentController.text,
                          email: emailController.text,
                          name: nameController.text)));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
