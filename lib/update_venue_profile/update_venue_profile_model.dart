import '/flutter_flow/flutter_flow_util.dart';
import 'update_venue_profile_widget.dart' show UpdateVenueProfileWidget;
import 'package:flutter/material.dart';

class UpdateVenueProfileModel
    extends FlutterFlowModel<UpdateVenueProfileWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataHuv = false;
  FFUploadedFile uploadedLocalFile_uploadDataHuv =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataHuv = '';

  // State field(s) for offerDetails widget.
  FocusNode? offerDetailsFocusNode;
  TextEditingController? offerDetailsTextController;
  String? Function(BuildContext, String?)? offerDetailsTextControllerValidator;
  // State field(s) for barDetails widget.
  FocusNode? barDetailsFocusNode;
  TextEditingController? barDetailsTextController;
  String? Function(BuildContext, String?)? barDetailsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    offerDetailsFocusNode?.dispose();
    offerDetailsTextController?.dispose();

    barDetailsFocusNode?.dispose();
    barDetailsTextController?.dispose();
  }
}
