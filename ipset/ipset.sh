#!/bin/bash

maclist_data=$(cat acces.txt)

# создаём таблицы бля тарификации трафика
ipset create acces hash:mac
ipset create acces_1 hash:mac
ipset create 70mbit hash:ip skbinfo
#ipset create 70mbit_1 hash:ip skbinfo

# перебираем по очереди кадую строчку из файла и добавляем в таблицу ipset MAC адреса для ограничения доступа в интернет
for acces in $maclist_data; do ipset -exist add acces_1 ${acces}; done
# меняем таблицы с новыми значениями для бесшовного изменения тарифов и добавления/удаления пользователей
ipset swap acces acces_1
# удаляем таблицу для ее очистки
ipset destroy acces_1

ipset restore -! < /opt/utm/ipset/Tarif_70mbit.txt

#for j in $tarif_70mbit; do ipset -exist add 70mbit_1 ${j}; done
#ipset swap 70mbit 70mbit_1
#ipset destroy 70mbit_1

