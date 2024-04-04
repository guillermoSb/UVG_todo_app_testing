Future<void> delay(bool addDelay, [int milliseconds = 500]) async {
  if (addDelay) {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}
