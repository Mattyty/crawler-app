import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'map_action_button_model.dart';
export 'map_action_button_model.dart';

class MapActionButtonWidget extends StatefulWidget {
  const MapActionButtonWidget({
    super.key,
    this.icon,
  });

  final Widget? icon;

  @override
  State<MapActionButtonWidget> createState() => _MapActionButtonWidgetState();
}

class _MapActionButtonWidgetState extends State<MapActionButtonWidget> {
  late MapActionButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapActionButtonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.0,
      height: 48.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24.0),
        shape: BoxShape.rectangle,
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: widget.icon!,
    );
  }
}
