import '/backend/supabase/supabase.dart';
import '/components/city_selector_copy_widget.dart';
import '/components/city_selector_widget.dart';
import '/components/no_more_h_h_widget.dart';
import '/components/persona_selector_widget.dart';
import '/components/seacrh_drop_down_row_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bar_home_page_model.dart';
export 'bar_home_page_model.dart';

class BarHomePageWidget extends StatefulWidget {
  const BarHomePageWidget({super.key});

  static String routeName = 'BarHomePage';
  static String routePath = '/barHomePage';

  @override
  State<BarHomePageWidget> createState() => _BarHomePageWidgetState();
}

class _BarHomePageWidgetState extends State<BarHomePageWidget>
    with TickerProviderStateMixin {
  late BarHomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BarHomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('BAR_HOME_BarHomePage_ON_INIT_STATE');
      if (!(FFAppState().userPersona != '')) {
        logFirebaseEvent('BarHomePage_bottom_sheet');
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: CitySelectorWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      }
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.switchValue = false;
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    return FutureBuilder<List<BarsRow>>(
      // FIX 1: Provide a fallback to 'Manchester' so the database query doesn't choke on an empty string
      future: BarsTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'city',
          FFAppState().currentCity.isEmpty ? 'Manchester' : FFAppState().currentCity,
        ),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<BarsRow> barHomePageBarsRowList = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            drawer: Drawer(
              elevation: 16.0,
              child: Container(
                width: 300.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF121212),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 140.0,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(18.0, 20.0, 0.0, 0.0),
                            child: Icon(
                              Icons.person_2,
                              color: Color(0xFFE1B12C),
                              size: 24.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'Your Profile',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                                  child: Icon(
                                    Icons.home,
                                    color: Color(0xFFE1B12C),
                                    size: 24.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 20.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent('BAR_HOME_PAGE_PAGE_Text_ugvx41j7_ON_TAP');
                                      logFirebaseEvent('Text_navigate_to');
                                      context.pushNamed(BarHomePageWidget.routeName);
                                    },
                                    child: Text(
                                      'Home',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent('BAR_HOME_PAGE_PAGE_Row_bk5c3z6h_ON_TAP');
                                logFirebaseEvent('Row_bottom_sheet');
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        FocusManager.instance.primaryFocus?.unfocus();
                                      },
                                      child: Padding(
                                        padding: MediaQuery.viewInsetsOf(context),
                                        child: CitySelectorCopyWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Color(0xFFE1B12C),
                                      size: 24.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 20.0),
                                    child: Text(
                                      'City: ',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 20.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent('BAR_HOME_PAGE_PAGE_Text_x9xmetee_ON_TAP');
                                        logFirebaseEvent('Text_bottom_sheet');
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context).unfocus();
                                                FocusManager.instance.primaryFocus?.unfocus();
                                              },
                                              child: Padding(
                                                padding: MediaQuery.viewInsetsOf(context),
                                                child: CitySelectorCopyWidget(),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      child: Text(
                                        valueOrDefault<String>(
                                          FFAppState().currentCity,
                                          'Manchester',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                              ),
                                              color: const Color(0xFFE1B12C),
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                            child: Icon(
                              Icons.account_circle,
                              color: Color(0xFFE1B12C),
                              size: 24.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 20.0),
                            child: Text(
                              'Profile: ',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 20.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent('BAR_HOME_PAGE_PAGE_Text_o04diitq_ON_TAP');
                                logFirebaseEvent('Text_bottom_sheet');
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        FocusManager.instance.primaryFocus?.unfocus();
                                      },
                                      child: Padding(
                                        padding: MediaQuery.viewInsetsOf(context),
                                        child: PersonaSelectorWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Text(
                                valueOrDefault<String>(
                                  FFAppState().userPersona,
                                  'Student',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                      ),
                                      color: const Color(0xFFE1B12C),
                                      letterSpacing: 0.0,
                                    ),
                               ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                            child: Icon(
                              Icons.storefront_sharp,
                              color: Color(0xFFE1B12C),
                              size: 24.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 20.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent('BAR_HOME_PAGE_PAGE_Text_iaowa592_ON_TAP');
                                logFirebaseEvent('Text_navigate_to');

                                context.pushNamed(
                                  LoginPageWidget.routeName,
                                  extra: <String, dynamic>{
                                    '__transition_info__': TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.rightToLeft,
                                    ),
                                  },
                                );
                              },
                              child: Text(
                                'Partner Login',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                            child: Icon(
                              Icons.waving_hand,
                              color: Color(0xFFE1B12C),
                              size: 24.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 20.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent('BAR_HOME_PAGE_PAGE_Text_viugnlvn_ON_TAP');
                                logFirebaseEvent('Text_navigate_to');
                                context.pushNamed(BarHomePageWidget.routeName);
                              },
                              child: Text(
                                'About Us',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 99.11,
                  decoration: const BoxDecoration(
                    color: Color(0xFF121212),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent('BAR_HOME_PAGE_PAGE_Icon_k79dafzy_ON_TAP');
                              logFirebaseEvent('Icon_drawer');
                              scaffoldKey.currentState!.openDrawer();
                            },
                            child: const Icon(
                              Icons.menu,
                              color: Color(0xFFE1B12C),
                              size: 30.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'CRAWLER',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                  ),
                                  color: const Color(0xFFE1B12C),
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 3.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 1.0),
                            )
                          ],
                          borderRadius: BorderRadius.circular(40.0),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                color: Color(0xFF606A85),
                                size: 24.0,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 200.0,
                                    child: TextFormField(
                                      controller: _model.textController,
                                      focusNode: _model.textFieldFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textController',
                                        // FIX 2: Dropped debounce from 2000ms down to a snappy 350ms
                                        const Duration(milliseconds: 350),
                                        () async {
                                          logFirebaseEvent('BAR_HOME_TextField_gk28zxtz_ON_TEXTFIELD');
                                          logFirebaseEvent('TextField_bottom_sheet');
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context).unfocus();
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                },
                                                child: Padding(
                                                  padding: MediaQuery.viewInsetsOf(context),
                                                  child: Container(
                                                    height: 250.0,
                                                    child: SeacrhDropDownRowWidget(
                                                      searchTerm: _model.textController.text,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(() {}));
                                        },
                                      ),
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Search Bars',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                              ),
                                              color: const Color(0xFF606A85),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                            ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                              ),
                                              color: const Color(0xFF606A85),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                            ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                            ),
                                            color: const Color(0xFF15161E),
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                          ),
                                      cursorColor: const Color(0xFF6F61EF),
                                      validator: _model.textControllerValidator.asValidator(context),
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
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: const Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: const Color(0xFF15161E),
                          unselectedLabelColor: const Color(0xFF606A85),
                          labelStyle: FlutterFlowTheme.of(context).labelSmall.override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                ),
                                color: const Color(0xFF606A85),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                              ),
                          unselectedLabelStyle: const TextStyle(),
                          indicatorColor: const Color(0xFF6F61EF),
                          padding: const EdgeInsets.all(4.0),
                          tabs: const [
                            Tab(
                              text: 'Bars',
                              icon: FaIcon(FontAwesomeIcons.beer),
                            ),
                            Tab(
                              text: 'Map',
                              icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                                    child: FutureBuilder<List<BarsRow>>(
                                      future: BarsTable().querySingleRow(
                                        queryFn: (q) => q.eqOrNull(
                                          'is_flash_active',
                                          true,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
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
                                        List<BarsRow> flashSaleSectionBarsRowList = snapshot.data!;

                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final flashSaleSectionBarsRow = flashSaleSectionBarsRowList.isNotEmpty
                                                ? flashSaleSectionBarsRowList.first
                                                : null;

                                        return Container(
                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                          decoration: const BoxDecoration(),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (barHomePageBarsRowList.length == 1)
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(12.0),
                                                      child: Container(
                                                        width: MediaQuery.sizeOf(context).width * 1.0,
                                                        height: 180.0,
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                          borderRadius: BorderRadius.circular(12.0),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: BorderRadius.circular(8.0),
                                                              child: Image.network(
                                                                valueOrDefault<String>(
                                                                  barHomePageBarsRowList.firstOrNull?.imageUrl,
                                                                  'https://picsum.photos/seed/342/600',
                                                                ),
                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                height: MediaQuery.sizeOf(context).height * 1.0,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                            Opacity(
                                                              opacity: 0.6,
                                                              child: Align(
                                                                alignment: const AlignmentDirectional(0.0, 1.0),
                                                                child: Container(
                                                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                                                  height: MediaQuery.sizeOf(context).height * 0.12,
                                                                  decoration: BoxDecoration(
                                                                    color: const Color(0xFF181717),
                                                                    border: Border.all(
                                                                      color: const Color(0xFF090909),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: const AlignmentDirectional(0.0, 0.0),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                                                                    child: Row(
                                                                      mainAxisSize: MainAxisSize.max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 0.0, 0.0),
                                                                          child: Text(
                                                                            valueOrDefault<String>(
                                                                              flashSaleSectionBarsRow?.name,
                                                                              'Albert Schloss',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                  color: const Color(0xFFE1B12C),
                                                                                  fontSize: 24.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 0.0, 0.0),
                                                                        child: Text(
                                                                          valueOrDefault<String>(
                                                                            flashSaleSectionBarsRow?.flashDescription,
                                                                            '2-4-1 cocktails',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                color: const Color(0xFFE1B12C),
                                                                                fontSize: 18.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 0.0, 0.0),
                                                                        child: Text(
                                                                          'Offer ends at ${flashSaleSectionBarsRow?.flashExpiresAt?.toString()}',
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                color: const Color(0xFFE1B12C),
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (barHomePageBarsRowList.length > 1)
                                                  Container(
                                                    width: MediaQuery.sizeOf(context).width * 1.0,
                                                    height: 200.0,
                                                    decoration: const BoxDecoration(),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final flashBar = barHomePageBarsRowList.toList();

                                                        return ListView.builder(
                                                          padding: EdgeInsets.zero,
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: flashBar.length,
                                                          itemBuilder: (context, flashBarIndex) {
                                                            final flashBarItem = flashBar[flashBarIndex];
                                                            return Padding(
                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 12.0, 0.0),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(12.0),
                                                                child: Container(
                                                                  width: 300.0,
                                                                  height: 180.0,
                                                                  decoration: BoxDecoration(
                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                  ),
                                                                  child: Stack(
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                        child: Image.network(
                                                                          valueOrDefault<String>(
                                                                            flashBarItem.imageUrl,
                                                                            'https://picsum.photos/seed/929/600',
                                                                          ),
                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                          height: MediaQuery.sizeOf(context).height * 1.0,
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                                                      Opacity(
                                                                        opacity: 0.6,
                                                                        child: Align(
                                                                          alignment: const AlignmentDirectional(0.0, 1.0),
                                                                          child: Container(
                                                                            width: MediaQuery.sizeOf(context).width * 1.0,
                                                                            height: MediaQuery.sizeOf(context).height * 0.12,
                                                                            decoration: BoxDecoration(
                                                                              color: const Color(0xFF181717),
                                                                              border: Border.all(
                                                                                color: const Color(0xFF090909),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                                                        child: Column(
                                                                          mainAxisSize: MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        flashBarItem.name,
                                                                                        'Albert Schloss',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                            color: const Color(0xFFE1B12C),
                                                                                            fontSize: 24.0,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 0.0, 0.0),
                                                                                  child: Text(
                                                                                    valueOrDefault<String>(
                                                                                      flashBarItem.flashDescription,
                                                                                      '50% OFF ALL DRINKS!!',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                          color: const Color(0xFFE1B12C),
                                                                                          fontSize: 18.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 0.0, 0.0),
                                                                                  child: Text(
                                                                                    'Offer Ends @ ${valueOrDefault<String>(
                                                                                      flashBarItem.flashExpiresAt?.toString(),
                                                                                      '17:00',
                                                                                    )}',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                          color: const Color(0xFFE1B12C),
                                                                                          fontSize: 20.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 0.0, 0.0),
                                      child: Text(
                                        'Top Deals...',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(6.0, 6.0, 0.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                      height: 190.0,
                                      decoration: const BoxDecoration(),
                                      child: Builder(
                                        builder: (context) {
                                          final featuredItem = barHomePageBarsRowList.toList();

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: featuredItem.length,
                                            itemBuilder: (context, featuredItemIndex) {
                                              final featuredItemItem = featuredItem[featuredItemIndex];
                                              return Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    logFirebaseEvent('BAR_HOME_Container_e4n9xk6h_ON_TAP');
                                                    logFirebaseEvent('Container_navigate_to');

                                                    context.pushNamed(
                                                      BarDetailWidget.routeName,
                                                      queryParameters: {
                                                        'barRecord': serializeParam(
                                                          featuredItemItem,
                                                          ParamType.SupabaseRow,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        '__transition_info__': TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType: PageTransitionType.rightToLeft,
                                                        ),
                                                      },
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(12.0),
                                                    child: Container(
                                                      width: 160.0,
                                                      height: MediaQuery.sizeOf(context).height * 1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                        borderRadius: BorderRadius.circular(12.0),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            child: Image.network(
                                                              valueOrDefault<String>(
                                                                featuredItemItem.imageUrl,
                                                                'https://picsum.photos/seed/929/600',
                                                              ),
                                                              width: MediaQuery.sizeOf(context).width * 1.0,
                                                              height: 150.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                                                                    child: Text(
                                                                      valueOrDefault<String>(
                                                                        featuredItemItem.name,
                                                                        'Bar Name',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                            letterSpacing: 0.0,
                                                                          ),
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                                                                child: FutureBuilder<List<OffersRow>>(
                                                                  future: OffersTable().querySingleRow(
                                                                    queryFn: (q) => q
                                                                        .eqOrNull(
                                                                          'bar_id',
                                                                          valueOrDefault<int>(featuredItemItem.id, 1),
                                                                        )
                                                                        .eqOrNull(
                                                                          'day_of_week',
                                                                          dateTimeFormat("EEEE", getCurrentTimestamp),
                                                                        ),
                                                                  ),
                                                                  builder: (context, snapshot) {
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
                                                                    List<OffersRow> textOffersRowList = snapshot.data!;
                                                                    final textOffersRow = textOffersRowList.isNotEmpty ? textOffersRowList.first : null;

                                                                    return Text(
                                                                      valueOrDefault<String>(
                                                                        textOffersRow?.dealSummary,
                                                                        '2-4-1 cocktails',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                            fontSize: 11.0,
                                                                            letterSpacing: 0.0,
                                                                          ),
                                                                      overflow: TextOverflow.ellipsis,
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2.0,
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment: const AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 120.0, 0.0),
                                              child: Text(
                                                'Other Deals \nHappening Now..',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment: const AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'Sort by:\nFreshest / Closest',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.inter(),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          Switch.adaptive(
                                            value: _model.switchValue!,
                                            onChanged: (barHomePageBarsRowList.isEmpty)
                                                ? null
                                                : (newValue) async {
                                                    safeSetState(() => _model.switchValue = newValue);
                                                  },
                                            activeColor: (barHomePageBarsRowList.isEmpty)
                                                    ? FlutterFlowTheme.of(context).primaryText
                                                    : const Color(0xFF121212),
                                            activeTrackColor: (barHomePageBarsRowList.isEmpty)
                                                    ? FlutterFlowTheme.of(context).primaryText
                                                    : const Color(0xFFE1B12C),
                                            inactiveTrackColor: (barHomePageBarsRowList.isEmpty)
                                                    ? FlutterFlowTheme.of(context).primaryBackground
                                                    : const Color(0xFFE1B12C),
                                            inactiveThumbColor: (barHomePageBarsRowList.isEmpty)
                                                    ? FlutterFlowTheme.of(context).alternate
                                                    : const Color(0xFF121212),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Spacer(),
                                    ],
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (barHomePageBarsRowList.isNotEmpty) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                          child: FutureBuilder<List<OffersRow>>(
                                            future: OffersTable().queryRows(
                                              queryFn: (q) => q
                                                  .eqOrNull(
                                                    'day_of_week',
                                                    dateTimeFormat("EEEE", getCurrentTimestamp),
                                                  )
                                                  .lteOrNull(
                                                    'start_time',
                                                    supaSerialize<PostgresTime>(PostgresTime(getCurrentTimestamp)),
                                                  )
                                                  .gteOrNull(
                                                    'end_time',
                                                    supaSerialize<PostgresTime>(PostgresTime(getCurrentTimestamp)),
                                                  ),
                                            ),
                                            builder: (context, snapshot) {
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
                                              List<OffersRow> listLiveNowOffersRowList = snapshot.data!;

                                              if (listLiveNowOffersRowList.isEmpty) {
                                                return const NoMoreHHWidget();
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: listLiveNowOffersRowList.length,
                                                separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                                                itemBuilder: (context, listLiveNowIndex) {
                                                  final listLiveNowOffersRow = listLiveNowOffersRowList[listLiveNowIndex];
                                                  return Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      FutureBuilder<List<BarsRow>>(
                                                        future: BarsTable().querySingleRow(
                                                          queryFn: (q) => q.eqOrNull(
                                                            'id',
                                                            listLiveNowOffersRow.barId,
                                                          ),
                                                        ),
                                                        builder: (context, snapshot) {
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
                                                          List<BarsRow> containerBarsRowList = snapshot.data!;
                                                          final containerBarsRow = containerBarsRowList.isNotEmpty ? containerBarsRowList.first : null;

                                                          return InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              logFirebaseEvent('BAR_HOME_Container_m7yhaowg_ON_TAP');
                                                              logFirebaseEvent('Container_navigate_to');

                                                              context.pushNamed(
                                                                BarDetailWidget.routeName,
                                                                queryParameters: {
                                                                  'barRecord': serializeParam(
                                                                    containerBarsRow,
                                                                    ParamType.SupabaseRow,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String, dynamic>{
                                                                  '__transition_info__': TransitionInfo(
                                                                    hasTransition: true,
                                                                    transitionType: PageTransitionType.rightToLeft,
                                                                  ),
                                                                },
                                                              );
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                height: 90.0,
                                                                decoration: BoxDecoration(
                                                                  color: const Color(0xFF121212),
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                                                                      child: Container(
                                                                        width: 80.0,
                                                                        height: 80.0,
                                                                        child: Stack(
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(6.0),
                                                                              child: Image.network(
                                                                                valueOrDefault<String>(
                                                                                  containerBarsRow?.imageUrl,
                                                                                  'https://picsum.photos/seed/929/600',
                                                                                ),
                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: Align(
                                                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                                                        child: Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.max,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        containerBarsRow?.name,
                                                                                        'Albert Schloss',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                            color: const Color(0xFFE1B12C),
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        listLiveNowOffersRow.dealSummary,
                                                                                        '2-4-1 cocktails',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(),
                                                                                            color: const Color(0xFFE1B12C),
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 12.0, 0.0),
                                                                                    child: Text(
                                                                                      '${valueOrDefault<String>(listLiveNowOffersRow.startTime?.time?.toString(), '12:00')} - ${valueOrDefault<String>(listLiveNowOffersRow.endTime?.time?.toString(), '17:00')}',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(),
                                                                                            color: const Color(0xFFE1B12C),
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        functions.getDistanceToBar(currentUserLocationValue, containerBarsRow?.lat, containerBarsRow?.long),
                                                                                        '0.1m',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(),
                                                                                            color: const Color(0xFFE1B12C),
                                                                                            fontSize: 14.0,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
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
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context).width * 0.6,
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              borderRadius: BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color: const Color(0xFFB0AEAE),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Opacity(
                                                  opacity: 0.4,
                                                  child: Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                    child: const FaIcon(
                                                      FontAwesomeIcons.clock,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ),
                                                Opacity(
                                                  opacity: 0.7,
                                                  child: Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                                                    child: Text(
                                                      'There are no Happy Hours running, right now. Check back, shortly - or see what\'s coming up later today 👇',
                                                      textAlign: TextAlign.center,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                font: GoogleFonts.inter(),
                                                                letterSpacing: 0.0,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Divider(
                                    thickness: 2.0,
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Deals Coming Up Later...',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (barHomePageBarsRowList.isNotEmpty) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 0.0),
                                          child: FutureBuilder<List<OffersRow>>(
                                            future: OffersTable().queryRows(
                                              queryFn: (q) => q
                                                  // FIX 3: Fixed format string to use EEEE day names so Supabase doesn't get a broken timestamp string
                                                  .eqOrNull(
                                                    'day_of_week',
                                                    dateTimeFormat("EEEE", getCurrentTimestamp),
                                                  )
                                                  .gtOrNull(
                                                    'start_time',
                                                    supaSerialize<PostgresTime>(PostgresTime(getCurrentTimestamp)),
                                                  ),
                                            ),
                                            builder: (context, snapshot) {
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
                                              List<OffersRow> listComigUpOffersRowList = snapshot.data!;

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: listComigUpOffersRowList.length,
                                                separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                                                itemBuilder: (context, listComigUpIndex) {
                                                  final listComigUpOffersRow = listComigUpOffersRowList[listComigUpIndex];
                                                  return Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      FutureBuilder<List<BarsRow>>(
                                                        future: BarsTable().querySingleRow(
                                                          queryFn: (q) => q.eqOrNull(
                                                            'id',
                                                            listComigUpOffersRow.barId,
                                                          ),
                                                        ),
                                                        builder: (context, snapshot) {
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
                                                          List<BarsRow> containerBarsRowList = snapshot.data!;
                                                          final containerBarsRow = containerBarsRowList.isNotEmpty ? containerBarsRowList.first : null;

                                                          return InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              logFirebaseEvent('BAR_HOME_Container_si6u90bf_ON_TAP');
                                                              logFirebaseEvent('Container_navigate_to');

                                                              context.pushNamed(
                                                                BarDetailWidget.routeName,
                                                                queryParameters: {
                                                                  'barRecord': serializeParam(
                                                                    containerBarsRow,
                                                                    ParamType.SupabaseRow,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String, dynamic>{
                                                                  '__transition_info__': TransitionInfo(
                                                                    hasTransition: true,
                                                                    transitionType: PageTransitionType.rightToLeft,
                                                                  ),
                                                                },
                                                              );
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                height: 90.0,
                                                                decoration: const BoxDecoration(
                                                                  color: Color(0xFFEAE8E8),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                                                                      child: Container(
                                                                        width: 80.0,
                                                                        height: 80.0,
                                                                        child: Stack(
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(6.0),
                                                                              child: Image.network(
                                                                                'https://picsum.photos/seed/940/600',
                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: Opacity(
                                                                        opacity: 0.7,
                                                                        child: Align(
                                                                          alignment: const AlignmentDirectional(0.0, 0.0),
                                                                          child: Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                            child: Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          containerBarsRow?.name,
                                                                                          'Albert Schloss',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.bold,
                                                                                              ),
                                                                                              color: const Color(0xFF121212),
                                                                                              fontSize: 16.0,
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            valueOrDefault<String>(
                                                                                              listComigUpOffersRow.dealSummary,
                                                                                              '2-4-1 cocktails',
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.inter(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: const Color(0xFF121212),
                                                                                                  fontSize: 16.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 12.0, 0.0),
                                                                                      child: Text(
                                                                                        '${listComigUpOffersRow.startTime?.time?.toString()} - ${listComigUpOffersRow.endTime?.time?.toString()}',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: const Color(0xFF121212),
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          functions.getDistanceToBar(currentUserLocationValue, containerBarsRow?.lat, containerBarsRow?.long),
                                                                                          '0.1m',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: const Color(0xFF121212),
                                                                                              fontSize: 14.0,
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context).width * 0.6,
                                            height: 120.0,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              borderRadius: BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color: const Color(0xFFB0AEAE),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                const Opacity(
                                                  opacity: 0.4,
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.clock,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ),
                                                Opacity(
                                                  opacity: 0.7,
                                                  child: Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                                                    child: Text(
                                                      'There are no Happy Hours running, today. Check back tomorrow for more great deals!',
                                                      textAlign: TextAlign.center,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                font: GoogleFonts.inter(),
                                                                letterSpacing: 0.0,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ].divide(const SizedBox(height: 12.0)),
                              ),
                            ),
                            FlutterFlowGoogleMap(
                              controller: _model.googleMapsController,
                              onCameraIdle: (latLng) => _model.googleMapsCenter = latLng,
                              initialLocation: _model.googleMapsCenter ??= const LatLng(53.481, -2.2426),
                              markers: (functions.getLatLngFromGeog(
                                          barHomePageBarsRowList.map((e) => e.lat).withoutNulls.toList(),
                                          barHomePageBarsRowList.map((e) => e.long).withoutNulls.toList()) ??
                                      [])
                                  .map(
                                    (marker) => FlutterFlowMarker(
                                      marker.serialize(),
                                      marker,
                                    ),
                                  )
                                  .toList(),
                              markerColor: GoogleMarkerColor.violet,
                              mapType: MapType.normal,
                              style: GoogleMapStyle.standard,
                              initialZoom: 14.0,
                              allowInteraction: true,
                              allowZoom: true,
                              showZoomControls: true,
                              showLocation: true,
                              showCompass: false,
                              showMapToolbar: false,
                              showTraffic: false,
                              centerMapOnMarkerTap: true,
                              mapTakesGesturePreference: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
