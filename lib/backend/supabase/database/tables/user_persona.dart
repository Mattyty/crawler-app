import '../database.dart';

class UserPersonaTable extends SupabaseTable<UserPersonaRow> {
  @override
  String get tableName => 'user_persona';

  @override
  UserPersonaRow createRow(Map<String, dynamic> data) => UserPersonaRow(data);
}

class UserPersonaRow extends SupabaseDataRow {
  UserPersonaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserPersonaTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get city => getField<String>('city');
  set city(String? value) => setField<String>('city', value);

  String? get persona => getField<String>('persona');
  set persona(String? value) => setField<String>('persona', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
