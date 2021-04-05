part of 'edit_place_bloc.dart';

/// Состояние формы.
///
/// Основной класс состояния формы. Все остальные классы выполняют роль
/// надстройки над ним для дополнительной информации о состоянии формы.
@immutable
class EditPlaceState extends Equatable with FormValues {
  const EditPlaceState._({
    required this.name,
    required this.type,
    required this.lat,
    required this.lon,
    required this.photos,
    required this.description,
  });

  EditPlaceState.init(FormValueState commonState)
      : name = FormValue('', state: commonState),
        type = FormValue(null, state: commonState),
        lat = FormValue('', state: commonState),
        lon = FormValue('', state: commonState),
        photos = FormValue(const [], state: commonState),
        description = FormValue('', state: commonState);

  EditPlaceState.from(EditPlaceState state)
      : name = state.name,
        type = state.type,
        lat = state.lat,
        lon = state.lon,
        photos = state.photos,
        description = state.description;

  final FormValue<String> name;
  final FormValue<PlaceType?> type;
  final FormValue<String> lat;
  final FormValue<String> lon;
  final FormValue<List<Photo>> photos;
  final FormValue<String> description;

  @override
  List<FormValue> get values => [name, type, lat, lon, photos, description];

  @override
  List<Object?> get props => [values];

  EditPlaceState copyWith({
    FormValue<String>? name,
    FormValue<PlaceType?>? type,
    FormValue<String>? lat,
    FormValue<String>? lon,
    FormValue<List<Photo>>? photos,
    FormValue<String>? description,
  }) =>
      EditPlaceState._(
        name: name ?? this.name,
        type: type ?? this.type,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        photos: photos ?? this.photos,
        description: description ?? this.description,
      );

  @override
  // ignore: no_runtimetype_tostring
  String toString() => '$runtimeType:\n'
      '    name: $name\n'
      '    type: $type\n'
      '    lat: $lat\n'
      '    lon: $lon\n'
      '    photos: ${photos.value.length} ${photos.toString(value: false)}\n'
      '    description: $description\n'
      '    isModified: $isModified\n'
      '    isValid: $isValid';
}

/// Загрузка/соахранение.
class EditPlaceLoading extends EditPlaceState {
  EditPlaceLoading(EditPlaceState state) : super.from(state);
}

/// Ошибка загрузки.
class EditPlaceLoadingFailed extends EditPlaceState {
  EditPlaceLoadingFailed(EditPlaceState state, this.error) : super.from(state);

  final Exception error;
}

/// Ошибка сохранения.
class EditPlaceSavingFailed extends EditPlaceState {
  EditPlaceSavingFailed(EditPlaceState state, this.error) : super.from(state);

  final Exception error;
}

/// Информация сохранена.
class EditPlaceSaved extends EditPlaceState {
  EditPlaceSaved(EditPlaceState state) : super.from(state);
}
