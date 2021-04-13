class ValueWrapper<T> {
  ValueWrapper(this.value);

  final T value;
}

class ThemePreferenceStreamWrapper extends ValueWrapper<Stream<void>> {
  ThemePreferenceStreamWrapper(Stream<void> value) : super(value);
}

class ThemePreferenceSinkWrapper extends ValueWrapper<Sink<void>> {
  ThemePreferenceSinkWrapper(Sink<void> value) : super(value);
}