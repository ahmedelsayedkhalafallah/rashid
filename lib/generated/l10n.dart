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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get firstSplashTitle {
    return Intl.message(
      'Welcome',
      name: 'firstSplashTitle',
      desc: '',
      args: [],
    );
  }

  /// `Some thing to welcome here`
  String get firstSplashDiscription {
    return Intl.message(
      'Some thing to welcome here',
      name: 'firstSplashDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Let's begin!`
  String get firstSplashButtonText {
    return Intl.message(
      'Let\'s begin!',
      name: 'firstSplashButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Relax`
  String get secondSplashTitle {
    return Intl.message(
      'Relax',
      name: 'secondSplashTitle',
      desc: '',
      args: [],
    );
  }

  /// `secondSplashDiscription is to be written here`
  String get secondSplashDiscription {
    return Intl.message(
      'secondSplashDiscription is to be written here',
      name: 'secondSplashDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Care`
  String get thirdSplashTitle {
    return Intl.message(
      'Care',
      name: 'thirdSplashTitle',
      desc: '',
      args: [],
    );
  }

  /// `thirdSplashDiscription jjcdsjcndc`
  String get thirdSplashDiscription {
    return Intl.message(
      'thirdSplashDiscription jjcdsjcndc',
      name: 'thirdSplashDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Mood`
  String get fourthSplashTitle {
    return Intl.message(
      'Mood',
      name: 'fourthSplashTitle',
      desc: '',
      args: [],
    );
  }

  /// `fourthSplashDiscription kjhfeklcmds`
  String get fourthSplashDiscription {
    return Intl.message(
      'fourthSplashDiscription kjhfeklcmds',
      name: 'fourthSplashDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get fifthSplashTitle {
    return Intl.message(
      'Welcome',
      name: 'fifthSplashTitle',
      desc: '',
      args: [],
    );
  }

  /// `fifthSplashDiscriptionsbcbscsdjncdlkm vfdlkcjn`
  String get fifthSplashDiscription {
    return Intl.message(
      'fifthSplashDiscriptionsbcbscsdjncdlkm vfdlkcjn',
      name: 'fifthSplashDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get signIn {
    return Intl.message(
      'Log in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `skip`
  String get skip {
    return Intl.message(
      'skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Welcome, Sign in to your account`
  String get welcomeSignIn {
    return Intl.message(
      'Welcome, Sign in to your account',
      name: 'welcomeSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueButtonText {
    return Intl.message(
      'Continue',
      name: 'continueButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Continue With Facebook`
  String get continueWithFacebook {
    return Intl.message(
      'Continue With Facebook',
      name: 'continueWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue With Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue With Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continue With Apple`
  String get continueWithApple {
    return Intl.message(
      'Continue With Apple',
      name: 'continueWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get doNotHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'doNotHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get orText {
    return Intl.message(
      'Or',
      name: 'orText',
      desc: '',
      args: [],
    );
  }

  /// `Look like you don't have an account. Let's create a new account for`
  String get lookLikeDonotHaveAnAccount {
    return Intl.message(
      'Look like you don\'t have an account. Let\'s create a new account for',
      name: 'lookLikeDonotHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `By selecting Agree & Continue below, I agree to our `
  String get bySelectingYouAgree {
    return Intl.message(
      'By selecting Agree & Continue below, I agree to our ',
      name: 'bySelectingYouAgree',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service and Privacy Policy`
  String get termsOfServices {
    return Intl.message(
      'Terms of Service and Privacy Policy',
      name: 'termsOfServices',
      desc: '',
      args: [],
    );
  }

  /// `Agree and Continue`
  String get agreeAndContinue {
    return Intl.message(
      'Agree and Continue',
      name: 'agreeAndContinue',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailAddress {
    return Intl.message(
      'Email',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in this field`
  String get fillThisField {
    return Intl.message(
      'Please fill in this field',
      name: 'fillThisField',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get enterValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Reset Email has been sent to you`
  String get resetEmailSent {
    return Intl.message(
      'Reset Email has been sent to you',
      name: 'resetEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid password`
  String get enterValidPassword {
    return Intl.message(
      'Please enter a valid password',
      name: 'enterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Password`
  String get wrongPassword {
    return Intl.message(
      'Wrong Password',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Name Too Long`
  String get NameTooLong {
    return Intl.message(
      'Name Too Long',
      name: 'NameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `⚈  1 uppercase`
  String get upperCase {
    return Intl.message(
      '⚈  1 uppercase',
      name: 'upperCase',
      desc: '',
      args: [],
    );
  }

  /// `⚈  1 lowercase`
  String get lowerCase {
    return Intl.message(
      '⚈  1 lowercase',
      name: 'lowerCase',
      desc: '',
      args: [],
    );
  }

  /// `⚈  1 number`
  String get number {
    return Intl.message(
      '⚈  1 number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `⚈  1 special character`
  String get specialCharacter {
    return Intl.message(
      '⚈  1 special character',
      name: 'specialCharacter',
      desc: '',
      args: [],
    );
  }

  /// `⚈  8 minimum character`
  String get eightCharacters {
    return Intl.message(
      '⚈  8 minimum character',
      name: 'eightCharacters',
      desc: '',
      args: [],
    );
  }

  /// `Sayarah`
  String get appName {
    return Intl.message(
      'Sayarah',
      name: 'appName',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
