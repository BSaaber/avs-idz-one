.file  "main.c"
  .intel_syntax noprefix
  .text
  .section  .rodata
.LC0:
  .string  "%d %d"
.LC1:
  .string  "%d"
.LC2:
  .string  "%d "
  .text
  .globl  main
  .type  main, @function
 
# переменные хранятся на стеке по смещениям (отн. rbp):
# -56 | divider
# -52 | n
# -40 | array
# -8  | temp
# -12 | result_array_len
# -16 | i - первый цикл
# -48 | result_array
# -24 | result_temp
# -28 | i - второй цикл
 
main:
  push  rbp         # типовое начало функции,
  mov  rbp, rsp    # записываем на стек начало стекового блока памяти функции, вызвавшей main и сохраняем начало стекового блока памяти функции main
  sub  rsp, 64 # выделение места на стеке (для текущей функции main)
  lea  rdx, -56[rbp] # rdx := &divider | поместили адрес: вершина стека + 8 (адрес, по которому на стеке хранится переменная divider)
  lea  rax, -52[rbp] # rax := &n       | поместили адрес: вершина стека + 12 (адрес, по которому на стеке хранится переменная n)
  mov  rsi, rax      # rsi := &n       | поместили адрес: вершина стека + 12 (адрес, по которому на стеке хранится переменная n) (загружаем данные для вызова scanf)
  lea  rdi, .LC0[rip] # rdi := указатель на строку "%d %d" (загружаем данные для вызова scanf)
  mov  eax, 0 # scanf - функция с переменным числом аргументов. В al (который часть eax) ожидается  количество векторных регистров, используемых для хранения аргументов
  call  __isoc99_scanf@PLT # вызов функции scanf # вызов функции scanf с параметрами, заданными через регистры rdi, rsi
  mov  eax, DWORD PTR -52[rbp] # сохраняем значение n в регистре eax
  cdqe # расширение eax до восьмибайтового
  sal  rax, 2 # rax:= n * sizeof(int) | байтовый арифметический сдвиг значения rax на 2 влево == ( * sizeof(int))
  mov  rdi, rax # rdi := rax (загружаем данные для вызова malloc)
  call  malloc@PLT # вызов функции malloc
  mov  QWORD PTR -40[rbp], rax # по адресу rsp + 24 собираемся хранить array. Выгружаем туда значение (выгружаем туда адрес начала аллоцированного куска), которое вернула функция malloc
  #mov  rax, QWORD PTR -40[rbp] # глупенький компилятор, там ведь уже лежит нужное нам значение
  mov  QWORD PTR -8[rbp], rax  # по адресу rsp + 56 собираемся хранить temp. temp := array
  mov  DWORD PTR -12[rbp], 0 # обнуляем половину байтов (см ниже)
  mov  DWORD PTR -16[rbp], 0 # по адресу rsp + 40 собираемся хранить перменную i первого цикла.
                                      # Она восьмибайтная, и мы хотим записать в нее ноль. тут обнуляем половину, а выше - вторую половину байтов
  jmp  .L2 # переходим на метку .L2
.L4:
  mov  rax, QWORD PTR -8[rbp] # rax := temp
  mov  rsi, rax # rsi := temp (загружаем данные для вызова scanf)
 
  lea  rdi, .LC1[rip] # rdi := указатель на строку "%d" (загружаем данные для вызова scanf)
  mov  eax, 0 # затираем al (см scanf 1)
  call  __isoc99_scanf@PLT # вызов scanf
  mov  rax, QWORD PTR -8[rbp] # rax := temp 
  lea  rdx, 4[rax] # rdx := temp + 4)
  mov  QWORD PTR -8[rbp], rdx # temp = rdx (вкупе с предыдущей - temp++)
  mov  eax, DWORD PTR [rax] #  eax := *temp
  mov  ecx, DWORD PTR -56[rbp] # ecx := divider
  cdq # расширяем eax до edx:eax
  idiv  ecx # делим пару edx:eax, на ecx. Остаток в edx | edx := *temp % divider
  mov  eax, edx # eax := edx
  test  eax, eax # проверяем, не ноль ли результат
  jne  .L3 # если не ноль, пропускаем инкремент result_array_len
  add  DWORD PTR -12[rbp], 1 # если же ноль, то инкрементим
.L3: # ; ++i)
  add  DWORD PTR -16[rbp], 1
.L2: # ; i < n ;
  mov  eax, DWORD PTR -52[rbp] # eax := n
  cmp  DWORD PTR -16[rbp], eax # проверь i < n 
  jl  .L4 # если условие выполнено, входим в тело цикла
 
# иначе идем дальше по коду
# далее повторяющиеся приемы расписываются менее подробно
 
  # int* result_array = malloc( result_array_len * sizeof(int)); |  переменная result_array хранится на стеке по смещению отн. rbp: -48
  mov  eax, DWORD PTR -12[rbp]
  cdqe
  sal  rax, 2
  mov  rdi, rax
  call  malloc@PLT
  mov  QWORD PTR -48[rbp], rax 

  # temp = array
  mov  rax, QWORD PTR -40[rbp]
  mov  QWORD PTR -8[rbp], rax
 
  # int* result_temp = result_array | переменная result_temp хранится на стеке по смещению отн. rbp: -24
  mov  rax, QWORD PTR -48[rbp]
  mov  QWORD PTR -24[rbp], rax
  mov  DWORD PTR -28[rbp], 0
 
  # входим в цикл 2
  jmp  .L5
 
 
# if *temp % divider == 0
.L7:
  mov  rax, QWORD PTR -8[rbp]
  mov  eax, DWORD PTR [rax]
  mov  ecx, DWORD PTR -56[rbp]
  cdq
  idiv  ecx
  mov  eax, edx
  test  eax, eax
  jne  .L6
 
 
  # *result_temp++ = *temp;
  mov  rax, QWORD PTR -24[rbp]
  lea  rdx, 4[rax]
  mov  QWORD PTR -24[rbp], rdx
  mov  rdx, QWORD PTR -8[rbp]
  mov  edx, DWORD PTR [rdx]
  mov  DWORD PTR [rax], edx
 
 
.L6:
  add  QWORD PTR -8[rbp], 4 # temp++
  add  DWORD PTR -28[rbp], 1 # ++i
 
# ; i < n ; | переменная i хранится на стеке по смещению отн. rbp: -28
.L5:
  mov  eax, DWORD PTR -52[rbp]
  cmp  DWORD PTR -28[rbp], eax
  jl  .L7
 
 
  # result_temp = result_array
  mov  rax, QWORD PTR -48[rbp]
  mov  QWORD PTR -24[rbp], rax
  mov  DWORD PTR -32[rbp], 0
 
  # входим в цикл 3
  jmp  .L8
.L9:
  mov  rax, QWORD PTR -24[rbp]
  lea  rdx, 4[rax]
  mov  QWORD PTR -24[rbp], rdx
  mov  eax, DWORD PTR [rax]
  mov  esi, eax
  lea  rdi, .LC2[rip]
  mov  eax, 0
  call  printf@PLT
  add  DWORD PTR -32[rbp], 1
.L8:
  mov  eax, DWORD PTR -32[rbp]
  cmp  eax, DWORD PTR -12[rbp]
  jl  .L9
 
  # free(array)
  mov  rax, QWORD PTR -40[rbp]
  mov  rdi, rax
  call  free@PLT
 
  # free(result_array)
  mov  rax, QWORD PTR -48[rbp]
  mov  rdi, rax
  call  free@PLT
 
  mov  eax, 0 # показываем вызывающей функции, что всё прошло ок
  leave # возвращем ebp на место начала области стековой памяти вызывающей функции
  ret   # переносим управление обратно в вызывающую функцию
  .size  main, .-main
  .ident  "GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
  .section  .note.GNU-stack,"",@progbits
