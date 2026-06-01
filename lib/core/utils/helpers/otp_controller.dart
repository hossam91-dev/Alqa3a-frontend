import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

class OtpController {
  final int length;

  late final List<TextEditingController> controllers;
  late final List<FocusNode> focusNodes;

  final ValueNotifier<String> otpCodeNotifier = ValueNotifier<String>('');
  final ValueNotifier<bool> isOtpCompleteNotifier = ValueNotifier<bool>(false);

  OtpController({this.length = 6}) {
    controllers = List.generate(length, (index) => TextEditingController());
    focusNodes = List.generate(length, (index) => FocusNode());
  }

  void calculateOtp() {
    String currentCode = '';
    for (var controller in controllers) {
      currentCode += controller.text;
    }
    otpCodeNotifier.value = currentCode;
    isOtpCompleteNotifier.value = currentCode.length == length;
    debugPrint('Otp Code: $currentCode');
  }

  void handleOnChanged(int index, String value, BuildContext context){
    if(value.isNotEmpty){
      if(index < length -1){
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }else{
        focusNodes[index].unfocus();
      }
    }
    calculateOtp();
  }

  void handleBackspace(int index, KeyEvent event, BuildContext context){
    if(event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace){
      if(controllers[index].text.isEmpty && index >0){
        controllers[index - 1].clear();
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
        calculateOtp();
      }
    }
  }

  void dispose(){
    for(var c in controllers){
      c.dispose();
    }

    for(var f in focusNodes){
      f.dispose();
    }

    otpCodeNotifier.dispose();
    isOtpCompleteNotifier.dispose();
  }

  
}
