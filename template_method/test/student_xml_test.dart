import 'package:template_method/template_method.dart';
import 'package:test/test.dart';

void main() {
  group('Xml 계산기 검증', () {
    test('Xml 데이터로 부터 클래스가 생성되는지 검증', () {
      final StudentsBmiCalculator xmlBmiCalculator = StudentsXmlBmiCalculator();

      final _studnetList = xmlBmiCalculator.calculateBmiAndReturnStudentList();

      expect(_studnetList.length, 4);
    });

    test('파싱 결과 값이 Student List인지 확인', () {
      final StudentsBmiCalculator xmlBmiCalculator = StudentsXmlBmiCalculator();

      final _studnetList = xmlBmiCalculator.calculateBmiAndReturnStudentList();

      expect(_studnetList.runtimeType, List<Student>);
    });
  });

  test('첫 번째 데이터의 bmi가 제대로 계산 되는지 검증', () {
    final StudentsBmiCalculator xmlBmiCalculator = StudentsXmlBmiCalculator();

    final _firstData =
        xmlBmiCalculator.calculateBmiAndReturnStudentList().first;

    expect(_firstData.bmi, 20.195092211553114);
  });
}
