import 'package:education_app/shared/app_strings.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    final isAvailable = await  hasBiometrics();
    if (!isAvailable) return false;
    try {
      return await _auth.authenticate(
          localizedReason: AppString.authResason,
          options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
              useErrorDialogs: true,
              sensitiveTransaction: true));
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> hasBiometrics()async {
    try{
      return await _auth.canCheckBiometrics;
    }on PlatformException catch(e){
      return false;
    }
  }
}
