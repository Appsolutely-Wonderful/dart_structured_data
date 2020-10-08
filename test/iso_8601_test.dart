import 'package:dart_recipe_schema/src/utils/iso_8601.dart';
import 'package:test/test.dart';

void main() {
  test('Verify basic matches on ISO 8601 Duration', () {
    String time = "P12Y"; // 12 years
    Duration result = Iso8601.parseDuration(time);
    expect(result.inDays, 4032);

    time = "P1DT12H"; // 1 day, 12 hours
    result = Iso8601.parseDuration(time);
    expect(result.inHours, 36);

    time = "P1W1DT12H"; // 1 week, 1 day, 12 hours
    result = Iso8601.parseDuration(time);
    expect(result.inHours, 204);

    time = "PT15M"; // 1 week, 1 day, 12 hours
    result = Iso8601.parseDuration(time);
    expect(result.inMinutes, 15);
  });
}
