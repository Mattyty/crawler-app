import '../database.dart';

class BarsTable extends SupabaseTable<BarsRow> {
  @override
  String get tableName => 'bars';

  @override
  BarsRow createRow(Map<String, dynamic> data) => BarsRow(data);
}

class BarsRow extends SupabaseDataRow {
  BarsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => BarsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get address => getField<String>('address');
  set address(String? value) => setField<String>('address', value);

  double? get lat => getField<double>('lat');
  set lat(double? value) => setField<double>('lat', value);

  double? get long => getField<double>('long');
  set long(double? value) => setField<double>('long', value);

  String? get neighborhood => getField<String>('neighborhood');
  set neighborhood(String? value) => setField<String>('neighborhood', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);

  String? get rawMarkdown => getField<String>('raw_markdown');
  set rawMarkdown(String? value) => setField<String>('raw_markdown', value);

  String? get location => getField<String>('location');
  set location(String? value) => setField<String>('location', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  bool? get isFlashActive => getField<bool>('is_flash_active');
  set isFlashActive(bool? value) => setField<bool>('is_flash_active', value);

  String? get flashDescription => getField<String>('flash_description');
  set flashDescription(String? value) =>
      setField<String>('flash_description', value);

  DateTime? get flashExpiresAt => getField<DateTime>('flash_expires_at');
  set flashExpiresAt(DateTime? value) =>
      setField<DateTime>('flash_expires_at', value);

  String? get tableReservation => getField<String>('table_reservation');
  set tableReservation(String? value) =>
      setField<String>('table_reservation', value);

  DateTime? get flashStartTime => getField<DateTime>('flash_start_time');
  set flashStartTime(DateTime? value) =>
      setField<DateTime>('flash_start_time', value);

  String? get flashSummary => getField<String>('flash_summary');
  set flashSummary(String? value) => setField<String>('flash_summary', value);

  String? get barDescription => getField<String>('bar_description');
  set barDescription(String? value) =>
      setField<String>('bar_description', value);

  String? get city => getField<String>('city');
  set city(String? value) => setField<String>('city', value);
}
