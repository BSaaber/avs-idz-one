# Базовая программа
****
## Программа на C
 Очевидно, конечная задача решается не оптимально. Можно было динамически проверять числа в первом цикле и сразу выводить их на экран. Однако в общем условии было сказано, что программа должна сохранять данные в массив A, а потом формировать массив B, и лишь после выводить массив B. По этой причине некоторые действия, например, проверка числа на кратность лишь для определения размера массива B, могут выглядеть искусственно.
 ### Файлы
- **base.c** - базовая программа С одной функцией `main`.
- **base_compiled** - базовая программа на C, откомпилированная без модификации ассемблерного кода
- **clean_base_with_comments.s** - базовая программа на C скомпилированная до уровня ассемблерных команд, которая была откомпилирована с флагами: `-O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none`, а также модифицированна вручную и дополнена комментариями
- **clean_base_with_comments** - запускаемый файл модфицированной программы, скомпилированный без использования опций отладки
### Тестовое покрытие
Тесты ставят перед собой задачу проверки правильности работы программ на **корректных данных**. На входные данные наложены следующие условия:
- Размер массива A - натуральное число (исходя из того, что в условии это число было обозначено буквой n).
- Число-делитель не равно нулю, так как делимость на ноль (в обычном понимании) проверить нельзя.
- На вход программе подается ровно столько чисел для заполнения массива A, сколько было указано первым входным параметром.

Поскольку функционал программы одинаков для всех реализаций, представленные здесь тесты будут использоваться и для всех дальнейших программ.
#### Тест 1
Входные данные:
```
5 2
1 2 3 4 5
```
Ожидаемые выходные данные:
```
2 4
```
Результаты тестов:
![](/screenshots/test_one_base.png)
![](/screenshots/test_one_clean_base_with_comments.png)
#### Тест 2
Входные данные:
```
1 4242
42
```
Ожидаемые выходные данные:
```
```
![](/screenshots/test_two_base.png)
![](/screenshots/test_two_clean_base_with_comments.png)
#### Тест 3
Входные данные:
```
1 1
42
```
Ожидаемые выходные данные:
```
42
```
![](/screenshots/test_three_base.png)
![](/screenshots/test_three_clean_base_with_comments.png)
#### Тест 4
Входные данные:
```
5 2
-2 -1 0 1 2
```
Ожидаемые выходные данные:
```
-2 0 2
```
![](/screenshots/test_four_base.png)
![](/screenshots/test_four_clean_base_with_comments.png)
#### Тест 5
Входные данные:
```
7 -3
-7 -6 0 3 2 -9 6
```
Ожидаемые выходные данные:
```
-6 0 3 -9 6
```
![](/screenshots/test_five_base.png)
![](/screenshots/test_five_clean_base_with_comments.png)
