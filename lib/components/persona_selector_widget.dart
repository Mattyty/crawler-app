import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'persona_selector_model.dart';
export 'persona_selector_model.dart';

class PersonaSelectorWidget extends StatefulWidget {
  const PersonaSelectorWidget({super.key});

  @override
  State<PersonaSelectorWidget> createState() => _PersonaSelectorWidgetState();
}

class _PersonaSelectorWidgetState extends State<PersonaSelectorWidget> {
  late PersonaSelectorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PersonaSelectorModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 450.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                child: Text(
                  'What brings you to town?',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.interTight(
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .fontStyle,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E2E2),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('PERSONA_SELECTOR_Row_ix63qty1_ON_TAP');
                      logFirebaseEvent('Row_update_app_state');
                      FFAppState().currentCity = 'Manchester';
                      safeSetState(() {});
                      logFirebaseEvent('Row_backend_call');
                      _model.cityManchester = await UserPersonaTable().insert({
                        'city': 'Manchester',
                      });
                      logFirebaseEvent('Row_bottom_sheet');
                      Navigator.pop(context);

                      safeSetState(() {});
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: FaIcon(
                            FontAwesomeIcons.userGraduate,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'PERSONA_SELECTOR_Text_jhzqfgzr_ON_TAP');
                              logFirebaseEvent('Text_update_app_state');
                              FFAppState().userPersona = 'Student';
                              safeSetState(() {});
                              logFirebaseEvent('Text_backend_call');
                              await UserPersonaTable().insert({
                                'persona': 'Student',
                                'city': FFAppState().currentCity,
                              });
                              logFirebaseEvent('Text_bottom_sheet');
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Student',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E2E2),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('PERSONA_SELECTOR_Row_gsoybd52_ON_TAP');
                      logFirebaseEvent('Row_update_app_state');
                      FFAppState().currentCity = 'Liverpool';
                      safeSetState(() {});
                      logFirebaseEvent('Row_backend_call');
                      await UserPersonaTable().insert({
                        'city': 'Liverpool',
                      });
                      logFirebaseEvent('Row_bottom_sheet');
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: Icon(
                            Icons.work,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'PERSONA_SELECTOR_Text_61eoog6a_ON_TAP');
                              logFirebaseEvent('Text_update_app_state');
                              FFAppState().userPersona = 'Work';
                              safeSetState(() {});
                              logFirebaseEvent('Text_backend_call');
                              await UserPersonaTable().insert({
                                'persona': 'Work',
                                'city': FFAppState().currentCity,
                              });
                              logFirebaseEvent('Text_bottom_sheet');
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Work',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E2E2),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('PERSONA_SELECTOR_Row_tsukmj0i_ON_TAP');
                      logFirebaseEvent('Row_update_app_state');
                      FFAppState().currentCity = 'Liverpool';
                      safeSetState(() {});
                      logFirebaseEvent('Row_backend_call');
                      await UserPersonaTable().insert({
                        'city': 'Liverpool',
                      });
                      logFirebaseEvent('Row_bottom_sheet');
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: Icon(
                            Icons.house_sharp,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'PERSONA_SELECTOR_Text_ra9u71lh_ON_TAP');
                              logFirebaseEvent('Text_update_app_state');
                              FFAppState().userPersona = 'Resident';
                              safeSetState(() {});
                              logFirebaseEvent('Text_backend_call');
                              await UserPersonaTable().insert({
                                'persona': 'Work',
                                'city': FFAppState().currentCity,
                              });
                              logFirebaseEvent('Text_bottom_sheet');
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Resident',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E2E2),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('PERSONA_SELECTOR_Row_lib8ix18_ON_TAP');
                      logFirebaseEvent('Row_update_app_state');
                      FFAppState().currentCity = 'Liverpool';
                      safeSetState(() {});
                      logFirebaseEvent('Row_backend_call');
                      await UserPersonaTable().insert({
                        'city': 'Liverpool',
                      });
                      logFirebaseEvent('Row_bottom_sheet');
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: FaIcon(
                            FontAwesomeIcons.beer,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'PERSONA_SELECTOR_Text_7gb2ipxx_ON_TAP');
                              logFirebaseEvent('Text_update_app_state');
                              FFAppState().userPersona = 'Visitor';
                              safeSetState(() {});
                              logFirebaseEvent('Text_backend_call');
                              await UserPersonaTable().insert({
                                'persona': 'Visitor',
                                'city': FFAppState().currentCity,
                              });
                              logFirebaseEvent('Text_bottom_sheet');
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Visitor',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
