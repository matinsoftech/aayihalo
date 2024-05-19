import 'package:get/get_utils/src/platform/platform.dart';
import 'package:flutter/foundation.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';


class CustomValidator {

  static Future<PhoneValid> isPhoneValid(String number) async {
    String phone = number;
    bool isValid = !(GetPlatform.isAndroid && !kIsWeb);
    if(GetPlatform.isAndroid && !kIsWeb) {
      try {
        PhoneNumber phoneNumber = await PhoneNumber.parse(number);
        phone = '+${phoneNumber.countryCode}${phoneNumber.isoCode}';
        isValid = true;
      } catch (_) {}
    }
    return PhoneValid(isValid: isValid, phone: phone);
  }

}

class PhoneValid {
  bool isValid;
  String phone;
  PhoneValid({required this.isValid, required this.phone});
}