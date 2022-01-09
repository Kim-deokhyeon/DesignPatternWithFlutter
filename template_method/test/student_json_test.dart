import 'package:template_method/template_method.dart';
import 'package:test/test.dart';

void main() {
  group('Json 계산기 검증', () {
    test('Json 데이터로 부터 클래스가 생성되는지 검증', () {
      final StudentsBmiCalculator jsonBmiCalculator =
          StudentsJsonBmiCalculator();

      final _studnetList = jsonBmiCalculator.calculateBmiAndReturnStudentList();

      expect(_studnetList.length, 4);
    });

    test('파싱 결과 값이 Student List인지 확인', () {
      final StudentsBmiCalculator jsonBmiCalculator =
          StudentsJsonBmiCalculator();

      final _studnetList = jsonBmiCalculator.calculateBmiAndReturnStudentList();

      expect(_studnetList.runtimeType, List<Student>);
    });

    test('첫 번째 데이터의 bmi가 제대로 계산 되는지 검증', () {
      final StudentsBmiCalculator jsonBmiCalculator =
          StudentsJsonBmiCalculator();

      final _firstData =
          jsonBmiCalculator.calculateBmiAndReturnStudentList().first;

      expect(_firstData.bmi, 20.195092211553114);
    });
  });
}
