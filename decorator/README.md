# Decorator Method

Github: https://github.com/Kim-deokhyeon/DesignPatternWithFlutter/tree/main/template_method
담당자: 익명
상태: 초안 🛠
생성일시: 2022년 1월 11일 오후 11:42
최종 편집일시: 2022년 1월 12일 오전 1:18

<aside>
💡 **Move Embellishment to Decorator**

> 어떤 클래스에 핵심 기능을 위한 코드와 꾸밈 코드가 뒤섞여 있으면, 꾸밈 코드를 데코레이터 `decorator`로 옮긴다
> 
</aside>

# 🚩 동기

 시스템에 새 기능을 추가해야 할 때면, 보통은 기존 클래스에 코드를 덧붙인다. 이렇게 새로 추가된 코드는 기존 클래스의 핵심 기능 또는 주된 행동 양식에 대한 꾸밈 코드로서 동작하는 경우가 많다. 문제는 이런 꾸밈 코드로 인해 새로운 필드 또는 메서드, 로직이 추가되고 호스트 클래스가 복잡해진다는 것이다. 게다가 새로 추가된 부분은 특정 조건에서만 쓰이는 것이다.

### 투명한 외투

호스트 클래스가 제공하는 모든 public 메서드를 데코레이터도 구현해야 한다.

호스트 클래스에 public 메서드가 많다면, 쓸데없는 코드가 데코레이터에 생길 가능성이 크다.

클라이언트에 객체의 타입을 명시적으로 검사하는 코드가 있다면, 데코레이터 객체와 그 대상이 되는 객체의 타입이 다르기 때문에 문제가 생길 수 있다.

따라서 객체의 타입에 의존하지 않도록 클라이언트의 코드를 수정하는 것이 가능하므로 큰 문제가 되지는 않는다.

### 다양한 데코레이터

데코레이터 클래스가 여럿 존재하는 경우도 고려해야 한다.

적옹 된 데코레이터 클래스의 순서로 인해 원하지 않는 결과가 나올 수 도 있다.

예를 들어 암호화 기능을 가진 데코레이터와 필터링 된 데코레이터의 경우, 암호화 후 필터링은 필터링의 의미가 없어진다.

서로 독립적이게 작성할 수 있으면 좋지만, 그렇지 못할 경우, **Encapsulate Classes with Factory** 등을 통해 안전한 조합을 제공하는 특별한 생성 메서드를 제공하는 것이 좋다.

### 장점과 단점

| 장점                                                         | 단점                                                                                      |
| ------------------------------------------------------------ | ----------------------------------------------------------------------------------------- |
| 꾸밈 코드를 제거해 호스트 클래스를 단순하게 만든다.          | 클라이언트의 입장에서는 대상 객체의 타입이 바뀐다.                                        |
| 어떤 클래스의 핵심 기능과 부가 기능을 손쉽게 구별할 수 있다. | 코드를 이해하고 디버깅하기 더 어려워질 수도 있다.                                         |
| 서로 관련된 클래스에서 중복된 꾸밈 코드를 줄일 수 있다.      | 데코레이터 객체의 조합 방식이 서로에게 영향을 끼친다면, 설계를 더 복잡하게 만들어야 한다. |

# 🔑 절차

### 사전 준비

- 핵심 기능에 다른 기능을 추가하기 위한 꾸밈 코드를 가지고 있는 클래스를 찾는다.
- 꾸밈 코드를 가지고 있다고 무조건 Decorator 패턴을 적용해 리팩터링 해야하는 것은 아니다.
- 리팩터링을 하기로 결정하기 전에 데코레이터 클래스가 구현해야 할 public 메서드가 많지 않은지 확인해보아야 한다.
- 메서드가 너무 많은 경우 적절한 작업을 통해 그 수를 줄이거나, **Replace Conditional Login with Strategy** 리팩터링과 같은 대안을 고려해야 한다.

### 1. 인클로저 타입 `enclosure type`을 찾아내거나 새로 만든다.

- 인클로저 타입이란,
    
    호스트 클래스의 클라이언트가 사용하는 모든 public 메서드를 제공하는 클래스 또는 인터페이스로, 데코레이터 클래스와 호스트 클래스 둘 모두에 대한 수퍼타입이 될 존재다.
    
- 경우에 따라 인클로저 타입을 새로 만들 필요 없이, 호스트 클래스가 구현한 인터페이스 타입이나 호스트 클래스의 수퍼클래스를 그대로 이용할 수 있다.
- 그러나 그러한 클래스가 데이터를 유지하고 있다면 인클로저 타입으로 적당하지 않다.
    
    → 데코레이터는 그런 데이터가 필요없음에도 상속 받기 때문에
    
- 인클로저 타입으로 사용할 적당한 후보가 없으면, **Unify Intefaces** 리팩터링 또는 **Extract Interface** 리팩터링을 통해 새로 만들어야 한다.

### 2. 호스트 클래스에서 꾸밈 코드에 해당하는 조건 로직을 찾아서 *Replace Conditional with Polymorphism* 리팩터링을 통해 제거한다.

- **Replace Conditional with Polymorphism** 을 적용하기 위해선 적절한 상속 구조가 요구되기 때문에 **Replace Type Code with Subclasses** 또는 **Replace Type Code with State/Strategy**를 사용해야 한다.
- **Replace Type Code with Subclasses**의 ****절차에서 그 첫 단계로 타입 코드를 자체 캡슐화 `self-encapsulation`를 할 것을 제시하고 있으며, 그 지침에 따라 타입 코드에 대한 get 메서드를 만들 경우, 리턴 타입이 앞 단계의 인클로저 타입이도록 하는 것이 중요하다.
- 수퍼클래스에서 타입 코드 필드를 제거할 때, 타입 코드에 대한 get/set 메서드를 추상으로 선언하라고 하지만, 굳이 그럴 필요는 없다.
- 꾸밈 코드의 앞이나 뒤에서 실행해야 할 로직이 있다면, **Replace Conditional with Polymorphism** 리팩터링과 함께 **Form Template Method** 리팩터링을 사용할 수 있다.

### 3. *Replace Inheritance with Delegation* 리팩터링을 이용해 이 서브클래스들을 위임 클래스`delegating class`로 변환한다.

- 위임 클래스는 모두 인클로저 타입을 구현하도록 한다.
- 위임 클래스의 대리 객체 필드도 인클로저 타입으로 한다.
- 꾸밈 코드를 위임 클래스가 위임 메서드를 호출하기 전에 실행할 것인지 아니면 그 후에 실행할 것인지를 결정한다.
- **Form Template Method** 리팩터링을 적용했다면, 위임 클래스에서 대리 객체의 public이 아닌 메서드를 호출해야할 상황이 벌어질 수 있다.
    
    그러한 경우 해당 메서드를 public으로 변경하고 **Unify Interfaces** 리팩터링을 다시 적용한다.
    

### 4. 각 위임 클래스의 대리 객체 필드에 호스트 클래스의 새 인스턴스를 만들어 대입한다.

- 이 대입문은 위임 클래스의 생성자에 위치해야 한다.
- 호스트 클래스의 인스턴스를 생성하는 코드에 Extract Parameter 리팩터링을 적용해 파라미터로 뽑아낸다.
- 생성자의 파라미터 중 불필요한 것이 있다면 Remoe Paramter 리팩터링을 이용하여 제거한다.

# 🗒️ 코드

### 1. 인클로저 타입 구현

데코레이터 클래스에 인터페이스를 전달하기 위해서 인클로저 타입 Pizza을 abstract class로 구현

데코레이터 클래스로 꾸며지기 위한 호스트 클래스인 PizzaBase와 데코레이터 클래스의 구분을 위한 인터페이스인 PizzaDecorator 클래스 생성.

```dart
abstract class Pizza {
  @protected
  late String description;

  String getDescription();
  double getPrice();
}

class PizzaBase extends Pizza {
  PizzaBase(String description) {
    this.description = description;
  }

  @override
  String getDescription() {
    return description;
  }

  @override
  double getPrice() {
    return 3.0;
  }
}

abstract class PizzaDecorator extends Pizza {
  final Pizza pizza;

  PizzaDecorator(this.pizza);

  @override
  String getDescription() {
    return pizza.getDescription();
  }

  @override
  double getPrice() {
    return pizza.getPrice();
  }
}
```

### 2. 데코레이터 클래스 구현

PizzaDecorator의 인터페이스를 상속해 메서드를 작성한 데코레이터 클래스.

인클로저 타입인 Pizza의 상태를 Return 할 수 있도록 작성해야 함.

Decorator 중첩을 통해서 Pizza의 description과 price를 쌓아감

```dart
class Basil extends PizzaDecorator {
  Basil(Pizza pizza) : super(pizza) {
    description = 'Basil';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.2;
  }
}

class Mozzarella extends PizzaDecorator {
  Mozzarella(Pizza pizza) : super(pizza) {
    description = 'Mozzarella';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.5;
  }
}

													....

class OliveOil extends PizzaDecorator {
  OliveOil(Pizza pizza) : super(pizza) {
    description = 'Olive Oil';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.1;
  }
}
```

### 3. 구현 된 클래스의 사용

인클로저 타입인 Pizza를 구현한 데코레이터 클래스로 꾸밈을 반복하게 되면, getDescrition과 getPrice를 통해 계속 값이 쌓여감을 확인할 수 있다.

```dart
void main() {
  Pizza pizza1 = PizzaBase('pizza1');
  pizza1 = Sauce(pizza1);
  pizza1 = Mozzarella(pizza1);
  pizza1 = Basil(pizza1);

  print(pizza1.getDescription());

  Pizza pizza2 = PizzaBase('pizza2');
  pizza2 = Sauce(pizza2);
  pizza2 = Mozzarella(pizza2);
  pizza2 = Basil(pizza2);

  print(pizza2.getDescription());
}
```