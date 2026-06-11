import '/flutter_flow/flutter_flow_util.dart';
import 'flash_page_builder_widget.dart' show FlashPageBuilderWidget;
import 'package:flutter/material.dart';

class FlashPageBuilderModel extends FlutterFlowModel<FlashPageBuilderWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for eg widget.
  FocusNode? egFocusNode;
  TextEditingController? egTextController;
  String? Function(BuildContext, String?)? egTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  DateTime? datePicked1;
  DateTime? datePicked2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    egFocusNode?.dispose();
    egTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController2?.dispose();
  }
}
