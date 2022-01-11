import 'package:decorator/model/decorator.dart';
import 'package:test/test.dart';

void main() {
  group('피자 데코레이터 검증', () {
    test('데코레이터로 description이 쌓이는지 검증', () {
      Pizza pizza1 = PizzaBase('pizza1');
      pizza1 = Sauce(pizza1);
      pizza1 = Mozzarella(pizza1);
      pizza1 = Basil(pizza1);

      expect(pizza1.getDescription(), 'pizza1\n- Sauce\n- Mozzarella\n- Basil');
    });

    test('데코레이터를 통해 pizza 가격이 잘 변경 되는지', () {
      Pizza pizza1 = PizzaBase('pizza1');
      expect(pizza1.getPrice(), 3.0);

      pizza1 = Sauce(pizza1);
      expect(pizza1.getPrice(), 3.3);

      pizza1 = Mozzarella(pizza1);
      expect(pizza1.getPrice(), 3.8);

      pizza1 = Basil(pizza1);
      expect(pizza1.getPrice(), 4.0);
    });
  });
}
