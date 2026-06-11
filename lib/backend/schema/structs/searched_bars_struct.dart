// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SearchedBarsStruct extends BaseStruct {
  SearchedBarsStruct({
    List<SearchedBarsStruct>? searchedBars,
  }) : _searchedBars = searchedBars;

  // "searchedBars" field.
  List<SearchedBarsStruct>? _searchedBars;
  List<SearchedBarsStruct> get searchedBars => _searchedBars ?? const [];
  set searchedBars(List<SearchedBarsStruct>? val) => _searchedBars = val;

  void updateSearchedBars(Function(List<SearchedBarsStruct>) updateFn) {
    updateFn(_searchedBars ??= []);
  }

  bool hasSearchedBars() => _searchedBars != null;

  static SearchedBarsStruct fromMap(Map<String, dynamic> data) =>
      SearchedBarsStruct(
        searchedBars: getStructList(
          data['searchedBars'],
          SearchedBarsStruct.fromMap,
        ),
      );

  static SearchedBarsStruct? maybeFromMap(dynamic data) => data is Map
      ? SearchedBarsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'searchedBars': _searchedBars?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'searchedBars': serializeParam(
          _searchedBars,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SearchedBarsStruct fromSerializableMap(Map<String, dynamic> data) =>
      SearchedBarsStruct(
        searchedBars: deserializeStructParam<SearchedBarsStruct>(
          data['searchedBars'],
          ParamType.DataStruct,
          true,
          structBuilder: SearchedBarsStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SearchedBarsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SearchedBarsStruct &&
        listEquality.equals(searchedBars, other.searchedBars);
  }

  @override
  int get hashCode => const ListEquality().hash([searchedBars]);
}

SearchedBarsStruct createSearchedBarsStruct() => SearchedBarsStruct();
