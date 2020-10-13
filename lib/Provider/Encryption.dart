import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class Encryption {
  Key key = Key.fromUtf8('my32lengthsupersecretnooneknows1');
  IV iv = IV.fromLength(16);

  String encryp(String text) {
    try {
      Key b64key = Key.fromUtf8(base64Url.encode(key.bytes));
      Fernet fernet = Fernet(b64key);
      Encrypter encrypter = Encrypter(fernet);
      return encrypter.encrypt(text).base64;
    } catch (e) {
      print(e);
    }

    return "";
  }

  String decrypt(String text) {
    try {
      Key b64key = Key.fromUtf8(base64Url.encode(key.bytes));
      Fernet fernet = Fernet(b64key);
      Encrypter encrypter = Encrypter(fernet);
      return encrypter.decrypt64(text);
    } catch (e) {
      print(e);
    }

    return "";
  }
}
