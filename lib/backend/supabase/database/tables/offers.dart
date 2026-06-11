import '../database.dart';

class OffersTable extends SupabaseTable<OffersRow> {
  @override
  String get tableName => 'offers';

  @override
  OffersRow createRow(Map<String, dynamic> data) => OffersRow(data);
}

class OffersRow extends SupabaseDataRow {
  OffersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => OffersTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get barId => getField<int>('bar_id')!;
  set barId(int value) => setField<int>('bar_id', value);

  String? get dealSummary => getField<String>('deal summary');
  set dealSummary(String? value) => setField<String>('deal summary', value);

  String? get dayOfWeek => getField<String>('day_of_week');
  set dayOfWeek(String? value) => setField<String>('day_of_week', value);

  DateTime? get lastVerified => getField<DateTime>('last_verified');
  set lastVerified(DateTime? value) =>
      setField<DateTime>('last_verified', value);

  String? get dealDescription => getField<String>('deal_description');
  set dealDescription(String? value) =>
      setField<String>('deal_description', value);

  PostgresTime? get startTime => getField<PostgresTime>('start_time');
  set startTime(PostgresTime? value) =>
      setField<PostgresTime>('start_time', value);

  PostgresTime? get endTime => getField<PostgresTime>('end_time');
  set endTime(PostgresTime? value) => setField<PostgresTime>('end_time', value);
}
