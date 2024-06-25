import 'dart:async';

import 'package:get/get.dart';

class OTPTimerController extends GetxController {
  var remainingTimeInSeconds = 60.obs;
  Timer? timer;
  //? timer function
  void startCountdownTimer() {
    cancelExistingTimer();
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSecond,
      (timer) {
        if (remainingTimeInSeconds.value > 0) {
          remainingTimeInSeconds.value -= 1; // Decrement by 1 second
        } else {
          // Countdown has reached 00:00, handle accordingly
          timer.cancel(); // Stop the timer
          // You can display a message here, e.g., "Please resend the code"
        }
      },
    );
  }

  void resetTimer() {
    remainingTimeInSeconds.value = 60;
    startCountdownTimer();
  }

  void cancelExistingTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  @override
  void onClose() {
    cancelExistingTimer(); // Cancel the timer when the controller is disposed
    super.onClose();
  }
}
