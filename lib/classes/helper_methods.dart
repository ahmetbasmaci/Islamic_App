import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/quran/quran_page.dart';

class HelperMethods {
  //to check if in debbug mode or not
  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static bool get isFirstTime {
    return true;
    bool isFirstTime = GetStorage().read<bool>('isFirstTime') ?? true;
    if (isFirstTime) {
      GetStorage().write('isFirstTime', false);
    }
    return isFirstTime;
  }

  static void setNewOpendPageId(String id) => GetStorage().write('lastOpendPageId', id);

  static String getNewOpendPageId() => GetStorage().read<String>('lastOpendPageId') ?? HomePage.id;

  static Widget getNewOpendPage() {
    switch (getNewOpendPageId()) {
      case HomePage.id:
        return HomePage();
      case QuranPage.id:
        return QuranPage();
      default:
        return HomePage();
    }
  }

  /// Normalise arabic text
  static String normalise(String input) {
    return input
        .replaceAll('ٱ', 'ا') //change alef
        .replaceAll('\u0610', '') //ARABIC SIGN SALLALLAHOU ALAYHE WA SALLAM
        .replaceAll('\u0611', '') //ARABIC SIGN ALAYHE ASSALLAM
        .replaceAll('\u0612', '') //ARABIC SIGN RAHMATULLAH ALAYHE
        .replaceAll('\u0613', '') //ARABIC SIGN RADI ALLAHOU ANHU
        .replaceAll('\u0614', '') //ARABIC SIGN TAKHALLUS

        //Remove koranic anotation
        .replaceAll('\u0615', '') //ARABIC SMALL HIGH TAH
        .replaceAll('\u0616', '') //ARABIC SMALL HIGH LIGATURE ALEF WITH LAM WITH YEH
        .replaceAll('\u0617', '') //ARABIC SMALL HIGH ZAIN
        .replaceAll('\u0618', '') //ARABIC SMALL FATHA
        .replaceAll('\u0619', '') //ARABIC SMALL DAMMA
        .replaceAll('\u061A', '') //ARABIC SMALL KASRA
        .replaceAll('\u06D6', '') //ARABIC SMALL HIGH LIGATURE SAD WITH LAM WITH ALEF MAKSURA
        .replaceAll('\u06D7', '') //ARABIC SMALL HIGH LIGATURE QAF WITH LAM WITH ALEF MAKSURA
        .replaceAll('\u06D8', '') //ARABIC SMALL HIGH MEEM INITIAL FORM
        .replaceAll('\u06D9', '') //ARABIC SMALL HIGH LAM ALEF
        .replaceAll('\u06DA', '') //ARABIC SMALL HIGH JEEM
        .replaceAll('\u06DB', '') //ARABIC SMALL HIGH THREE DOTS
        .replaceAll('\u06DC', '') //ARABIC SMALL HIGH SEEN
        .replaceAll('\u06DD', '') //ARABIC END OF AYAH
        .replaceAll('\u06DE', '') //ARABIC START OF RUB EL HIZB
        .replaceAll('\u06DF', '') //ARABIC SMALL HIGH ROUNDED ZERO
        .replaceAll('\u06E0', '') //ARABIC SMALL HIGH UPRIGHT RECTANGULAR ZERO
        .replaceAll('\u06E1', '') //ARABIC SMALL HIGH DOTLESS HEAD OF KHAH
        .replaceAll('\u06E2', '') //ARABIC SMALL HIGH MEEM ISOLATED FORM
        .replaceAll('\u06E3', '') //ARABIC SMALL LOW SEEN
        .replaceAll('\u06E4', '') //ARABIC SMALL HIGH MADDA
        .replaceAll('\u06E5', '') //ARABIC SMALL WAW
        .replaceAll('\u06E6', '') //ARABIC SMALL YEH
        .replaceAll('\u06E7', '') //ARABIC SMALL HIGH YEH
        .replaceAll('\u06E8', '') //ARABIC SMALL HIGH NOON
        .replaceAll('\u06E9', '') //ARABIC PLACE OF SAJDAH
        .replaceAll('\u06EA', '') //ARABIC EMPTY CENTRE LOW STOP
        .replaceAll('\u06EB', '') //ARABIC EMPTY CENTRE HIGH STOP
        .replaceAll('\u06EC', '') //ARABIC ROUNDED HIGH STOP WITH FILLED CENTRE
        .replaceAll('\u06ED', '') //ARABIC SMALL LOW MEEM

        //Remove tatweel
        .replaceAll('\u0640', '')

        //Remove tashkeel
        .replaceAll('\u064B', '') //ARABIC FATHATAN
        .replaceAll('\u064C', '') //ARABIC DAMMATAN
        .replaceAll('\u064D', '') //ARABIC KASRATAN
        .replaceAll('\u064E', '') //ARABIC FATHA
        .replaceAll('\u064F', '') //ARABIC DAMMA
        .replaceAll('\u0650', '') //ARABIC KASRA
        .replaceAll('\u0651', '') //ARABIC SHADDA
        .replaceAll('\u0652', '') //ARABIC SUKUN
        .replaceAll('\u0653', '') //ARABIC MADDAH ABOVE
        .replaceAll('\u0654', '') //ARABIC HAMZA ABOVE
        .replaceAll('\u0655', '') //ARABIC HAMZA BELOW
        .replaceAll('\u0656', '') //ARABIC SUBSCRIPT ALEF
        .replaceAll('\u0657', '') //ARABIC INVERTED DAMMA
        .replaceAll('\u0658', '') //ARABIC MARK NOON GHUNNA
        .replaceAll('\u0659', '') //ARABIC ZWARAKAY
        .replaceAll('\u065A', '') //ARABIC VOWEL SIGN SMALL V ABOVE
        .replaceAll('\u065B', '') //ARABIC VOWEL SIGN INVERTED SMALL V ABOVE
        .replaceAll('\u065C', '') //ARABIC VOWEL SIGN DOT BELOW
        .replaceAll('\u065D', '') //ARABIC REVERSED DAMMA
        .replaceAll('\u065E', '') //ARABIC FATHA WITH TWO DOTS
        .replaceAll('\u065F', '') //ARABIC WAVY HAMZA BELOW
        .replaceAll('\u0670', '') //ARABIC LETTER SUPERSCRIPT ALEF

        //Replace Waw Hamza Above by Waw
        .replaceAll('\u0624', '\u0648')

        //Replace Ta Marbuta by Ha
        // .replaceAll('\u0629', '\u0647')

        //Replace Ya
        // and Ya Hamza Above by Alif Maksura
        .replaceAll('\u064A', '\u0649')
        .replaceAll('\u0626', '\u0649')

        // Replace Alifs with Hamza Above/Below
        // and with Madda Above by Alif
        .replaceAll('\u0622', '\u0627')
        .replaceAll('\u0623', '\u0627')
        .replaceAll('\u0625', '\u0627');
  }

  /// Convert a number to arabic number
  static convertToArabicNumber(int ayahNumber) {
    String arabicNumber = ayahNumber.toString();
    arabicNumber = arabicNumber.replaceAll('0', '٠');
    arabicNumber = arabicNumber.replaceAll('1', '١');
    arabicNumber = arabicNumber.replaceAll('2', '٢');
    arabicNumber = arabicNumber.replaceAll('3', '٣');
    arabicNumber = arabicNumber.replaceAll('4', '٤');
    arabicNumber = arabicNumber.replaceAll('5', '٥');
    arabicNumber = arabicNumber.replaceAll('6', '٦');
    arabicNumber = arabicNumber.replaceAll('7', '٧');
    arabicNumber = arabicNumber.replaceAll('8', '٨');
    arabicNumber = arabicNumber.replaceAll('9', '٩');
    return arabicNumber;
  }

  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(msg: 'تم نسخ النص بنجاح'.tr);
    Clipboard.getData(Clipboard.kTextPlain).then((value) {});
  }
}
