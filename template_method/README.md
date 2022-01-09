# Form Template Method

담당자: 익명
상태: 현재 버전👍
생성일시: 2022년 1월 9일 오후 11:17
최종 편집일시: 2022년 1월 10일 오전 12:42

<aside>
💡 **Form Template Method**

> 한 상속 구조 내의 어떤 두 서브 클래스가 유사한 단위 작업을 같은 순서로 실행하는 메서드를 각자 구현하고 있다면, 각 단위 작업을 별도의 메서드로 뽑아내어 두 메서드를 일반화하고 이렇게 일반화된 메서드를 수퍼 클래스로 올려 템플릿 메서드 `template method`로 만든다
> 
</aside>

# 🚩 동기

템플릿 메서드는 ‘알고리즘에서 불변적인 부분은 한 번만 구현하고 가변적인 동작은 서브클래스에서 구현할 수 있도록 남겨둔 것’ 을 말한다.

### 불변적 동작

알고리즘을 구성하는 메서드 목록과 그 호출 순서

서브 클래스가 꼭 오버라이드 해야 할 추상 메서드

서브클래스가 오버라이드해도 되는 훅 메서드 `hook method`, 즉 구체 메서드

### 주의 사항

서브 클래스에서 오버라이드해야 하는 메서드가 너무 많으면 곤란하다.

서브 클래스의 구현이 어려워지기 때문

종종 생성자로써 **Factory Method**를 호출하는 경우도 있음.

클라이언트 코드에서 템플릿 메서드의 불변적인 부분을 변경할 필요가 없음이 확실하면 **final**로 선언하는 것도 괜찮은 방법이다.

### 장점과 단점

| 장점                                                                | 단점                                                                     |
| ------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| 서브클래스들의 공통 기능을 수퍼클래스로 옮겨, 중복 코드가 제거된다. | 서브클래스가 꼭 구현해야 하는 메서드의 개수가 많다면, 설계가 복잡해진다. |
| 알고리즘의 과정이 단순해지고, 쉽게 알아볼 수 있다.                  |                                                                          |
| 서브클래스에서 알고리즘의 구현을 재정의하는 것이 쉬워진다.          |                                                                          |

# 🔑 절차

### 1. 상속 구조 내의 서브클래스 사이에 유사 메서드가 존재하는지 확인한다.

- **유사 메서드**란,
    
    다른 서브 클래스에 있는 메서드와 **비슷한 작업**을 **비슷한 순서**로 수행하는 메서드를 말한다.
    
- 유사 메서드가 확인되면, 양쪽에 모두 **Compose  Method** 리팩터링을 적용한다..
- 과정에서 동일한 시그니처`feature의 의미`(특성)과 내용을 가지는 공통 메서드와 아닌 동일하지 않은 특수 메서드가 새로 생성될 수 있다.
- 특수 메서드의 경우, 결국 나중엔 수퍼클래스의 추상 메서드 혹은 훅 메서드로 만들어야 하기 때문에, 다른 서브 클래스가 상속하거나 오버라이드 할 필요가 없다면 처음부터 공통 메서드로 만든다. (이유는 단계 5에서)

### 2. 공통 메서드를 Pull Up Method 리팩터링을 통해 수퍼클래스로 올린다.

### 3. 양쪽 서브클래스에서 유사 메서드의 내용이 서로 같아지도록, 각 특수 메서드에 Rename Method 리팩터링을 적용한다.

- Rename Method 리팩터링을 한 번 적용할 때마다, 컴파일 후 테스트한다.

### 4. 혹시 두 유사 메서드의 시그니처가 동일하지 않다면, Rename Method 리팩터링을 적용해 동일하게 만든다.

### 5. 이제 양쪽 유사 메서드를 Pull Up Method 리팩터링을 통해 수퍼 클래스로 올린다.

- 각각의 특수 메서드에 대응하는 추상 메서드를 수퍼 클래스에 정의한다.
    
    단계 1에서 특수 메서드라 해도 공통 메서드로 만들라고 한 이유이다.
    
- 컴파일 후 테스트 한다.

# 🗒️ 코드

### 1. 수퍼 클래스 구현

getStudentData() 메서드의 경우, 서브 클래스 내부에서 각기 다른 형태로 구현 될 것이기 때문에 abstract method로 남겨둔다.

abstract method를 가지기 위해, 수퍼 클래스는 abstract class로 구현하였음.

```dart
abstract class StudentsBmiCalculator {
  List<Student> calculateBmiAndReturnStudentList() {
    var studentList = getStudentsData();
    studentList = doStudentsFiltering(studentList);
    _calculateStudentsBmi(studentList);
    return studentList;
  }

  void _calculateStudentsBmi(List<Student> studentList) {
    for (final student in studentList) {
      student.bmi = _calculateBmi(student.height, student.weight);
    }
  }

  double _calculateBmi(double height, int weight) {
    return weight / math.pow(height, 2);
  }

  // Hook methods
  @protected
  List<Student> doStudentsFiltering(List<Student> studentList) {
    return studentList;
  }

  // Abstract methods
  @protected
  List<Student> getStudentsData();
}
```

### 2. 서브 클래스 구현

서브 클래스의 목적은 각각 Json과 Xml 형태를 가진 Return value를 List<Student> 형태로 반환하기 위함이므로, 그에 따라추상 메서드인 getStudentData()를 오버라이드하여  List<Student>를 반환하게끔 선언한다.

```dart
class StudentsJsonBmiCalculator extends StudentsBmiCalculator {
  final JsonStudentsApi _api = JsonStudentsApi();

  @override
  List<Student> getStudentsData() {
    final studentsJson = _api.getStudentsJson();
    final studentsMap = json.decode(studentsJson) as Map<String, dynamic>;
    final studentsJsonList = studentsMap['students'] as List;
    final studentsList = studentsJsonList.map((json) {
      final studentJson = json as Map<String, dynamic>;

      return Student(
        fullName: studentJson['fullName'] as String,
        age: studentJson['age'] as int,
        height: studentJson['height'] as double,
        weight: studentJson['weight'] as int,
      );
    }).toList();

    return studentsList;
  }
}
```

```dart
class StudentsXmlBmiCalculator extends StudentsBmiCalculator {
  final XmlStudentsApi _api = XmlStudentsApi();

  @override
  @protected
  List<Student> getStudentsData() {
    final studentsXml = _api.getStudentsXml();
    final xmlDocument = XmlDocument.parse(studentsXml);
    final studentsList = <Student>[];

    for (final xmlElement in xmlDocument.findAllElements('student')) {
      final fullName = xmlElement.findElements('fullname').single.text;
      final age = int.parse(xmlElement.findElements('age').single.text);
      final height =
          double.parse(xmlElement.findElements('height').single.text);
      final weight = int.parse(xmlElement.findElements('weight').single.text);

      studentsList.add(Student(
        fullName: fullName,
        age: age,
        height: height,
        weight: weight,
      ));
    }

    return studentsList;
  }
}
```

### 3. 구현 된 클래스의 사용

StudentSection 위젯은 StudentsBmiCalculator에서 List<Student>의 값을 return 받아 데이터 테이블 형태로 출력한다.

따라서 StudentSection 위젯에 상속 된 서브 클래스를 주입하게 되면, Form Method로의 리팩터링이 완료되었다.

```dart
class StudentsSection extends StatefulWidget {
  final StudentsBmiCalculator bmiCalculator;
  final String headerText;

  const StudentsSection({
    required this.bmiCalculator,
    required this.headerText,
  });

  @override
  _StudentsSectionState createState() => _StudentsSectionState();
}

class _StudentsSectionState extends State<StudentsSection> {
  final List<Student> students = [];

  void _calculateBmiAndGetStudentsData() {
    setState(() {
      students.addAll(widget.bmiCalculator.calculateBmiAndReturnStudentList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.headerText),
        const SizedBox(height: LayoutConstants.spaceM),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _StudentsSectionContent(
            students: students,
            onPressed: _calculateBmiAndGetStudentsData,
          ),
        ),
      ],
    );
  }
}

class _StudentsSectionContent extends StatelessWidget {
  final List<Student> students;
  final VoidCallback onPressed;

  const _StudentsSectionContent({
    required this.students,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return students.isEmpty
        ? PlatformButton(
            materialColor: Colors.black,
            materialTextColor: Colors.white,
            onPressed: onPressed,
            text: "Calculate BMI and get students' data",
          )
        : StudentsDataTable(
            students: students,
          );
  }
}
```

```dart
class TemplateMethodExample extends StatelessWidget {
  const TemplateMethodExample();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StudentsSection(
              bmiCalculator: StudentsXmlBmiCalculator(),
              headerText: 'Students from XML data source:',
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            StudentsSection(
              bmiCalculator: StudentsJsonBmiCalculator(),
              headerText: 'Students from JSON data source:',
            ),
          ],
        ),
      ),
    );
  }
}
```