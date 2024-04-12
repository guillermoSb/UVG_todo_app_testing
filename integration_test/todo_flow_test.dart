import 'package:flutter_test/flutter_test.dart';

import '../test/src/robot.dart';

void main() {
  setUpAll(() => WidgetController.hitTestWarningShouldBeFatal = true);

  testWidgets('Integration test - full todo flow', (tester) async {
    // Arrange
    final robot = Robot(tester);
    await robot.pumpMyAppWithFakes(delay: false);
    // Act
    await robot.fullTodoFlow();
  });
}
