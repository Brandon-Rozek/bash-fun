#!/bin/bash
source ../src/fun.sh

seq 1 4 | sum
seq 1 4 | product
factorial 4
seq 1 4 | scanl lambda a b . 'echo $(add $a $b)'
echo map multiply
seq 1 4 | list_map lambda a . 'echo $(multiply $a 2)'
echo map minus
seq 1 4 | list_map lambda a . 'echo $(minus $a 2)'
echo map add
seq 1 4 | list_map lambda a . 'echo $(add $a 2)'
echo map divide
seq 1 4 | list_map lambda a . 'echo $(divide $a 2)'
echo list_map mod
seq 1 4 | list_map lambda a . 'echo $(mod $a 2)'
echo 'list & head'
list 1 2 3 4 5 | list_head
list {1..2} | list_append {3..4} | list_prepend {99..102}
list {1..2} | unlist
list {1..10} | list_head
list {1..10} | list_drop 7
list {1..10} | list_take 3
list {1..10} | list_last
list {1..10} | list_map λ a . 'echo $(multiply $a 2)'

id() { 
  λ x . '$x' 
}

id <<< 'echo :)'

foobar() { 
  product | λ l . 'list {1..$l}' | sum | md5sum 
}

list {1,2,3} | foobar

echo -n abcdefg | revers_str                # gfedcba
echo -n abcdefg | splitc | list_join ,           # a,b,c,d,e,f,g
echo -n abcdefg | splitc | revers | list_join ,  # g,f,e,d,c,b,a

list {1..10} | filter lambda a . '[[ $(mod $a 2) -eq 0 ]] && ret true || ret false' | list_join ,  # 2,4,6,8,10

list a b c d | foldl lambda acc el . 'echo -n $acc-$el'
seq 1 4 | foldl lambda acc el . 'echo $(($acc + $el))'

#1 - 2 - 3 - 4
seq 1 4 | foldl lambda acc el . 'echo $(($acc - $el))'

#1 + (1 + 1) * 2 + (4 + 1) * 3 + (15 + 1) * 4 = 64
seq 1 4 | foldl lambda acc el . 'echo $(multiply $(($acc + 1)) $el)'

tup a 1
tup a 1 | tupl
tup a 1 | tupr

list a b c d e f | list_zip $(seq 1 10)

echo
list a b c d e f | list_zip $(seq 1 10) | list_last | tupr

seq 1 5 | scanl lambda a b . 'echo $(($a + $b))'
seq 1 5 | scanl lambda a b . 'echo $(($a + $b))' | list_last

seq 2 3 | list_map lambda a . 'seq 1 $a' | list_join ,
list a b c | list_map lambda a . 'echo $a; echo $a | tr a-z A-z' | list_join ,
