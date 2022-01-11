import 'model/decorator.dart';

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
