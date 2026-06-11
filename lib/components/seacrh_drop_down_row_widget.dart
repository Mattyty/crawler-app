import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'seacrh_drop_down_row_model.dart';
export 'seacrh_drop_down_row_model.dart';

class SeacrhDropDownRowWidget extends StatefulWidget {
  const SeacrhDropDownRowWidget({
    super.key,
    this.barRow,
    String? searchTerm,
  }) : this.searchTerm = searchTerm ?? '';

  final String? barRow;

  /// AlbertSchloss
  final String searchTerm;

  @override
  State<SeacrhDropDownRowWidget> createState() =>
      _SeacrhDropDownRowWidgetState();
}

class _SeacrhDropDownRowWidgetState extends State<SeacrhDropDownRowWidget> {
  late SeacrhDropDownRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SeacrhDropDownRowModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        FutureBuilder<List<BarsRow>>(
          future: BarsTable().queryRows(
            queryFn: (q) => q
                .eqOrNull(
                  'city',
                  FFAppState().currentCity,
                )
                .like(
                  'name',
                  widget.searchTerm,
                ),
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              );
            }
            List<BarsRow> listViewBarsRowList = snapshot.data!;

            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listViewBarsRowList.length,
              itemBuilder: (context, listViewIndex) {
                final listViewBarsRow = listViewBarsRowList[listViewIndex];
                return InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'SEACRH_DROP_DOWN_ROW_Text_n9w74b1g_ON_TA');
                    logFirebaseEvent('Text_navigate_to');

                    context.pushNamed(
                      BarDetailWidget.routeName,
                      queryParameters: {
                        'barRecord': serializeParam(
                          listViewBarsRow,
                          ParamType.SupabaseRow,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Text(
                    listViewBarsRow.name,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
