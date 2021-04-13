// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Fechar`
  String get closeButtonText {
    return Intl.message(
      'Fechar',
      name: 'closeButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Pokémon`
  String get pokemonBottomNavigationItem {
    return Intl.message(
      'Pokémon',
      name: 'pokemonBottomNavigationItem',
      desc: '',
      args: [],
    );
  }

  /// `Favoritos`
  String get favoritesBottomNavigationItem {
    return Intl.message(
      'Favoritos',
      name: 'favoritesBottomNavigationItem',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível estabelecer comunicação, tente novamente.`
  String get genericErrorMessage {
    return Intl.message(
      'Não foi possível estabelecer comunicação, tente novamente.',
      name: 'genericErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Parece que você não está conectado à internet.`
  String get noConnectionErrorMessage {
    return Intl.message(
      'Parece que você não está conectado à internet.',
      name: 'noConnectionErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Tente novamente!`
  String get genericErrorActionButtonTitle {
    return Intl.message(
      'Tente novamente!',
      name: 'genericErrorActionButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Erro`
  String get genericErrorTitle {
    return Intl.message(
      'Erro',
      name: 'genericErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `PokéDapp`
  String get appBarTitle {
    return Intl.message(
      'PokéDapp',
      name: 'appBarTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}