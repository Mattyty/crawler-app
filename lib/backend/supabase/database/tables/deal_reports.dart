import '../database.dart';

class DealReportsTable extends SupabaseTable<DealReportsRow> {
  @override
  String get tableName => 'deal_reports';

  @override
  DealReportsRow createRow(Map<String, dynamic> data) => DealReportsRow(data);
}

class DealReportsRow extends SupabaseDataRow {
  DealReportsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DealReportsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get barName => getField<String>('bar_name');
  set barName(String? value) => setField<String>('bar_name', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
