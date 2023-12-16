part of 'locale_cubit.dart';

class LocaleState extends Equatable {
  final String locale;
  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}
