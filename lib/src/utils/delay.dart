Future<void> delay(bool addDelay, [int milliseconds = 300]) async {
  if (addDelay) {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}
