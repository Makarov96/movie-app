/// Generated file. Do not edit.
///
/// Original: i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 20 (10 per locale)
///
/// Built on 2024-03-22 at 23:28 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/api/translation_overrides.dart';
import 'package:slang/builder/model/build_model_config.dart';
import 'package:slang/builder/model/enums.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

/// Generated by the "Translation Overrides" feature.
/// This config is needed to recreate the translation model exactly
/// the same way as this file was created.
final _buildConfig = BuildModelConfig(
	fallbackStrategy: FallbackStrategy.none,
	keyCase: null,
	keyMapCase: null,
	paramCase: null,
	stringInterpolation: StringInterpolation.doubleBraces,
	maps: [],
	pluralAuto: PluralAuto.cardinal,
	pluralParameter: 'n',
	pluralCardinal: [],
	pluralOrdinal: [],
	contexts: [],
	interfaces: [], // currently not supported
);

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	es(languageCode: 'es', build: _TranslationsEs.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of texts).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = texts.someKey.anotherKey;
/// String b = texts['someKey.anotherKey']; // Only for edge cases!
Translations get texts => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final texts = Translations.of(context); // Get texts variable.
/// String a = texts.someKey.anotherKey; // Use texts variable.
/// String b = texts['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.texts.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get texts => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
	static void overrideTranslations({required AppLocale locale, required FileType fileType, required String content}) => instance.overrideTranslations(locale: locale, fileType: fileType, content: content);
	static void overrideTranslationsFromMap({required AppLocale locale, required bool isFlatMap, required Map map}) => instance.overrideTranslationsFromMap(locale: locale, isFlatMap: isFlatMap, map: map);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values, buildConfig: _buildConfig);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static Translations buildWithOverrides({required AppLocale locale, required FileType fileType, required String content, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.buildWithOverrides(locale: locale, fileType: fileType, content: content, cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);
	static Translations buildWithOverridesFromMap({required AppLocale locale, required bool isFlatMap, required Map map, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.buildWithOverridesFromMap(locale: locale, isFlatMap: isFlatMap, map: map, cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final texts = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	/// [AppLocaleUtils.buildWithOverrides] is recommended for overriding.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsDetailsEn details = _TranslationsDetailsEn._(_root);
	late final _TranslationsHomeEn home = _TranslationsHomeEn._(_root);
}

// Path: details
class _TranslationsDetailsEn {
	_TranslationsDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get popularity => TranslationOverrides.string(_root.$meta, 'details.popularity', {}) ?? 'Polularity:';
	String get votes => TranslationOverrides.string(_root.$meta, 'details.votes', {}) ?? 'Votes:';
	String get votesAverage => TranslationOverrides.string(_root.$meta, 'details.votesAverage', {}) ?? 'Votes Average:';
	String get originalTitle => TranslationOverrides.string(_root.$meta, 'details.originalTitle', {}) ?? 'Original title:';
	String get releaseDate => TranslationOverrides.string(_root.$meta, 'details.releaseDate', {}) ?? 'Release date:';
	String get originalLanguage => TranslationOverrides.string(_root.$meta, 'details.originalLanguage', {}) ?? 'Original Language:';
	String get overview => TranslationOverrides.string(_root.$meta, 'details.overview', {}) ?? 'Overview:';
}

// Path: home
class _TranslationsHomeEn {
	_TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => TranslationOverrides.string(_root.$meta, 'home.title', {}) ?? 'Kueski Movie';
	String get movies => TranslationOverrides.string(_root.$meta, 'home.movies', {}) ?? 'Movies';
	String get playingMovies => TranslationOverrides.string(_root.$meta, 'home.playingMovies', {}) ?? 'Playing Movies';
}

// Path: <root>
class _TranslationsEs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	/// [AppLocaleUtils.buildWithOverrides] is recommended for overriding.
	_TranslationsEs.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsEs _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsDetailsEs details = _TranslationsDetailsEs._(_root);
	@override late final _TranslationsHomeEs home = _TranslationsHomeEs._(_root);
}

// Path: details
class _TranslationsDetailsEs implements _TranslationsDetailsEn {
	_TranslationsDetailsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get popularity => TranslationOverrides.string(_root.$meta, 'details.popularity', {}) ?? 'Popularidad:';
	@override String get votes => TranslationOverrides.string(_root.$meta, 'details.votes', {}) ?? 'Votos:';
	@override String get votesAverage => TranslationOverrides.string(_root.$meta, 'details.votesAverage', {}) ?? 'Media de votos:';
	@override String get originalTitle => TranslationOverrides.string(_root.$meta, 'details.originalTitle', {}) ?? 'Titulo Original:';
	@override String get releaseDate => TranslationOverrides.string(_root.$meta, 'details.releaseDate', {}) ?? 'Fecha de lanze:';
	@override String get originalLanguage => TranslationOverrides.string(_root.$meta, 'details.originalLanguage', {}) ?? 'Idioma Original:';
	@override String get overview => TranslationOverrides.string(_root.$meta, 'details.overview', {}) ?? 'Resumen:';
}

// Path: home
class _TranslationsHomeEs implements _TranslationsHomeEn {
	_TranslationsHomeEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => TranslationOverrides.string(_root.$meta, 'home.title', {}) ?? 'Kueski Peliculas';
	@override String get movies => TranslationOverrides.string(_root.$meta, 'home.movies', {}) ?? 'Peliculas';
	@override String get playingMovies => TranslationOverrides.string(_root.$meta, 'home.playingMovies', {}) ?? 'En cine ahora';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'details.popularity': return TranslationOverrides.string(_root.$meta, 'details.popularity', {}) ?? 'Polularity:';
			case 'details.votes': return TranslationOverrides.string(_root.$meta, 'details.votes', {}) ?? 'Votes:';
			case 'details.votesAverage': return TranslationOverrides.string(_root.$meta, 'details.votesAverage', {}) ?? 'Votes Average:';
			case 'details.originalTitle': return TranslationOverrides.string(_root.$meta, 'details.originalTitle', {}) ?? 'Original title:';
			case 'details.releaseDate': return TranslationOverrides.string(_root.$meta, 'details.releaseDate', {}) ?? 'Release date:';
			case 'details.originalLanguage': return TranslationOverrides.string(_root.$meta, 'details.originalLanguage', {}) ?? 'Original Language:';
			case 'details.overview': return TranslationOverrides.string(_root.$meta, 'details.overview', {}) ?? 'Overview:';
			case 'home.title': return TranslationOverrides.string(_root.$meta, 'home.title', {}) ?? 'Kueski Movie';
			case 'home.movies': return TranslationOverrides.string(_root.$meta, 'home.movies', {}) ?? 'Movies';
			case 'home.playingMovies': return TranslationOverrides.string(_root.$meta, 'home.playingMovies', {}) ?? 'Playing Movies';
			default: return null;
		}
	}
}

extension on _TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'details.popularity': return TranslationOverrides.string(_root.$meta, 'details.popularity', {}) ?? 'Popularidad:';
			case 'details.votes': return TranslationOverrides.string(_root.$meta, 'details.votes', {}) ?? 'Votos:';
			case 'details.votesAverage': return TranslationOverrides.string(_root.$meta, 'details.votesAverage', {}) ?? 'Media de votos:';
			case 'details.originalTitle': return TranslationOverrides.string(_root.$meta, 'details.originalTitle', {}) ?? 'Titulo Original:';
			case 'details.releaseDate': return TranslationOverrides.string(_root.$meta, 'details.releaseDate', {}) ?? 'Fecha de lanze:';
			case 'details.originalLanguage': return TranslationOverrides.string(_root.$meta, 'details.originalLanguage', {}) ?? 'Idioma Original:';
			case 'details.overview': return TranslationOverrides.string(_root.$meta, 'details.overview', {}) ?? 'Resumen:';
			case 'home.title': return TranslationOverrides.string(_root.$meta, 'home.title', {}) ?? 'Kueski Peliculas';
			case 'home.movies': return TranslationOverrides.string(_root.$meta, 'home.movies', {}) ?? 'Peliculas';
			case 'home.playingMovies': return TranslationOverrides.string(_root.$meta, 'home.playingMovies', {}) ?? 'En cine ahora';
			default: return null;
		}
	}
}
