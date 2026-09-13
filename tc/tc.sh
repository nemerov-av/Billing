#!/bin/bash

LAN=ens19
LAN1=vlan5
LAN2=vlan7


tc qdisc del dev ${LAN} root
tc qdisc del dev ${LAN1} root
tc qdisc del dev ${LAN2} root
# cоздаём root дисциплину для сетевого устройства
tc qdisc add dev ${LAN} root handle 1:0 hfsc default 10
tc qdisc add dev ${LAN1} root handle 1:0 hfsc default 10
tc qdisc add dev ${LAN2} root handle 1:0 hfsc default 10
# создаём дочерний класс на 1го провайдера согласно размера трубы на данном устройстве
tc class add dev ${LAN} parent 1:0 classid 1:1 hfsc sc rate 300mbit ul rate 300mbit
tc class add dev ${LAN1} parent 1:0 classid 1:1 hfsc sc rate 300mbit ul rate 300mbit
tc class add dev ${LAN2} parent 1:0 classid 1:1 hfsc sc rate 300mbit ul rate 300mbit
# перенаправляем весь не тарифицируемый трафик в 1:10 и задаём низший приоритет обработки
tc filter add dev ${LAN} parent 1:0 protocol ip prio 1000 u32 match u32 0 0 classid 1:10
tc filter add dev ${LAN1} parent 1:0 protocol ip prio 1000 u32 match u32 0 0 classid 1:10
tc filter add dev ${LAN2} parent 1:0 protocol ip prio 1000 u32 match u32 0 0 classid 1:10
# задаём краевой класс с шириной канала для нертарифицируемого трафика
tc class add dev ${LAN} parent 1:0 classid 1:10 hfsc sc rate 1kbit ul rate 3kbit
tc class add dev ${LAN1} parent 1:0 classid 1:10 hfsc sc rate 1kbit ul rate 3kbit
tc class add dev ${LAN2} parent 1:0 classid 1:10 hfsc sc rate 1kbit ul rate 3kbit
# добавляем дисциплину для 1:10 устанавливающая очередь обработки пакетов pfifo с лимитом пакетов 50000
tc qdisc add dev ${LAN} parent 1:10 handle 10: pfifo limit 50000
tc qdisc add dev ${LAN1} parent 1:10 handle 10: pfifo limit 50000
tc qdisc add dev ${LAN2} parent 1:10 handle 10: pfifo limit 50000
# краевой класс от 1:1 для пользователей согласно тарифам по 98шт каждого тарифа
tc class add dev ${LAN} parent 1:0 classid 1:72 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:72 handle 72: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:73 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:73 handle 73: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:74 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:74 handle 74: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:75 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:75 handle 75: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:76 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:76 handle 76: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:77 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:77 handle 77: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:78 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:78 handle 78: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:79 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:79 handle 79: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:710 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:710 handle 710: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:711 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:711 handle 711: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:712 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:712 handle 712: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:713 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:713 handle 713: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:714 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:714 handle 714: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:715 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:715 handle 715: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:716 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:716 handle 716: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:717 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:717 handle 717: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:718 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:718 handle 718: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:719 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:719 handle 719: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:720 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:720 handle 720: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:721 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:721 handle 721: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:722 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:722 handle 722: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:723 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:723 handle 723: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:724 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:724 handle 724: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:725 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:725 handle 725: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:726 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:726 handle 726: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:727 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:727 handle 727: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:728 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:728 handle 728: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:729 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:729 handle 729: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:730 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:730 handle 730: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:731 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:731 handle 731: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:732 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:732 handle 732: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:733 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:733 handle 733: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:734 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:734 handle 734: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:735 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:735 handle 735: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:736 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:736 handle 736: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:737 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:737 handle 737: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:738 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:738 handle 738: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:739 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:739 handle 739: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:740 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:740 handle 740: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:741 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:741 handle 741: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:742 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:742 handle 742: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:743 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:743 handle 743: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:744 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:744 handle 744: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:745 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:745 handle 745: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:746 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:746 handle 746: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:747 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:747 handle 747: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:748 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:748 handle 748: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:749 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:749 handle 749: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:750 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:750 handle 750: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:751 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:751 handle 751: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:752 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:752 handle 752: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:753 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:753 handle 753: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:754 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:754 handle 754: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:755 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:755 handle 755: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:756 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:756 handle 756: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:757 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:757 handle 757: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:758 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:758 handle 758: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:759 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:759 handle 759: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:760 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:760 handle 760: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:761 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:761 handle 761: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:762 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:762 handle 762: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:763 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:763 handle 763: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:764 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:764 handle 764: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:765 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:765 handle 765: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:766 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:766 handle 766: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:767 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:767 handle 767: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:768 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:768 handle 768: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:769 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:769 handle 769: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:770 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:770 handle 770: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:771 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:771 handle 771: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:772 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:772 handle 772: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:773 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:773 handle 773: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:774 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:774 handle 774: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:775 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:775 handle 775: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:776 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:776 handle 776: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:777 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:777 handle 777: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:778 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:778 handle 778: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:779 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:779 handle 779: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:780 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:780 handle 780: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:781 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:781 handle 781: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:782 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:782 handle 782: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:783 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:783 handle 783: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:784 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:784 handle 784: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:785 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:785 handle 785: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:786 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:786 handle 786: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:787 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:787 handle 787: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:788 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:788 handle 788: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:789 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:789 handle 789: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:790 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:790 handle 790: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:791 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:791 handle 791: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:792 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:792 handle 792: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:793 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:793 handle 793: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:794 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:794 handle 794: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:795 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:795 handle 795: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:796 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:796 handle 796: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:797 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:797 handle 797: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:798 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:798 handle 798: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:799 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN} parent 1:799 handle 799: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:102 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:102 handle 102: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:103 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:103 handle 103: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:104 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:104 handle 104: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:105 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:105 handle 105: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:106 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:106 handle 106: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:107 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:107 handle 107: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:108 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:108 handle 108: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:109 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:109 handle 109: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1010 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1010 handle 1010: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1011 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1011 handle 1011: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1012 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1012 handle 1012: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1013 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1013 handle 1013: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1014 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1014 handle 1014: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1015 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1015 handle 1015: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1016 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1016 handle 1016: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1017 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1017 handle 1017: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1018 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1018 handle 1018: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1019 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1019 handle 1019: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1020 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1020 handle 1020: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1021 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1021 handle 1021: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1022 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1022 handle 1022: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1023 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1023 handle 1023: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1024 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1024 handle 1024: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1025 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1025 handle 1025: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1026 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1026 handle 1026: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1027 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1027 handle 1027: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1028 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1028 handle 1028: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1029 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1029 handle 1029: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1030 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1030 handle 1030: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1031 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1031 handle 1031: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1032 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1032 handle 1032: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1033 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1033 handle 1033: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1034 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1034 handle 1034: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1035 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1035 handle 1035: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1036 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1036 handle 1036: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1037 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1037 handle 1037: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1038 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1038 handle 1038: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1039 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1039 handle 1039: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1040 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1040 handle 1040: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1041 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1041 handle 1041: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1042 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1042 handle 1042: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1043 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1043 handle 1043: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1044 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1044 handle 1044: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1045 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1045 handle 1045: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1046 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1046 handle 1046: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1047 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1047 handle 1047: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1048 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1048 handle 1048: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1049 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1049 handle 1049: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1050 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1050 handle 1050: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1051 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1051 handle 1051: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1052 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1052 handle 1052: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1053 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1053 handle 1053: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1054 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1054 handle 1054: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1055 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1055 handle 1055: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1056 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1056 handle 1056: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1057 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1057 handle 1057: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1058 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1058 handle 1058: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1059 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1059 handle 1059: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1060 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1060 handle 1060: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1061 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1061 handle 1061: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1062 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1062 handle 1062: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1063 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1063 handle 1063: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1064 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1064 handle 1064: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1065 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1065 handle 1065: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1066 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1066 handle 1066: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1067 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1067 handle 1067: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1068 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1068 handle 1068: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1069 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1069 handle 1069: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1070 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1070 handle 1070: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1071 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1071 handle 1071: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1072 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1072 handle 1072: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1073 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1073 handle 1073: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1074 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1074 handle 1074: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1075 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1075 handle 1075: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1076 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1076 handle 1076: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1077 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1077 handle 1077: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1078 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1078 handle 1078: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1079 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1079 handle 1079: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1080 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1080 handle 1080: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1081 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1081 handle 1081: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1082 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1082 handle 1082: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1083 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1083 handle 1083: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1084 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1084 handle 1084: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1085 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1085 handle 1085: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1086 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1086 handle 1086: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1087 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1087 handle 1087: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1088 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1088 handle 1088: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1089 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1089 handle 1089: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1090 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1090 handle 1090: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1091 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1091 handle 1091: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1092 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1092 handle 1092: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1093 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1093 handle 1093: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1094 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1094 handle 1094: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1095 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1095 handle 1095: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1096 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1096 handle 1096: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1097 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1097 handle 1097: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1098 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1098 handle 1098: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1099 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1099 handle 1099: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:152 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:152 handle 152: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:153 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:153 handle 153: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:154 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:154 handle 154: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:155 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:155 handle 155: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:156 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:156 handle 156: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:157 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:157 handle 157: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:158 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:158 handle 158: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:159 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:159 handle 159: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1510 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1510 handle 1510: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1511 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1511 handle 1511: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1512 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1512 handle 1512: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1513 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1513 handle 1513: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1514 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1514 handle 1514: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1515 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1515 handle 1515: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1516 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1516 handle 1516: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1517 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1517 handle 1517: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1518 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1518 handle 1518: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1519 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1519 handle 1519: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1520 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1520 handle 1520: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1521 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1521 handle 1521: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1522 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1522 handle 1522: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1523 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1523 handle 1523: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1524 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1524 handle 1524: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1525 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1525 handle 1525: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1526 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1526 handle 1526: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1527 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1527 handle 1527: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1528 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1528 handle 1528: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1529 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1529 handle 1529: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1530 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1530 handle 1530: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1531 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1531 handle 1531: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1532 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1532 handle 1532: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1533 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1533 handle 1533: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1534 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1534 handle 1534: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1535 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1535 handle 1535: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1536 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1536 handle 1536: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1537 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1537 handle 1537: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1538 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1538 handle 1538: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1539 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1539 handle 1539: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1540 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1540 handle 1540: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1541 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1541 handle 1541: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1542 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1542 handle 1542: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1543 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1543 handle 1543: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1544 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1544 handle 1544: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1545 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1545 handle 1545: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1546 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1546 handle 1546: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1547 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1547 handle 1547: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1548 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1548 handle 1548: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1549 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1549 handle 1549: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1550 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1550 handle 1550: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1551 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1551 handle 1551: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1552 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1552 handle 1552: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1553 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1553 handle 1553: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1554 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1554 handle 1554: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1555 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1555 handle 1555: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1556 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1556 handle 1556: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1557 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1557 handle 1557: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1558 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1558 handle 1558: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1559 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1559 handle 1559: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1560 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1560 handle 1560: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1561 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1561 handle 1561: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1562 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1562 handle 1562: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1563 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1563 handle 1563: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1564 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1564 handle 1564: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1565 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1565 handle 1565: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1566 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1566 handle 1566: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1567 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1567 handle 1567: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1568 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1568 handle 1568: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1569 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1569 handle 1569: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1570 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1570 handle 1570: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1571 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1571 handle 1571: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1572 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1572 handle 1572: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1573 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1573 handle 1573: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1574 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1574 handle 1574: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1575 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1575 handle 1575: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1576 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1576 handle 1576: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1577 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1577 handle 1577: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1578 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1578 handle 1578: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1579 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1579 handle 1579: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1580 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1580 handle 1580: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1581 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1581 handle 1581: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1582 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1582 handle 1582: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1583 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1583 handle 1583: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1584 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1584 handle 1584: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1585 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1585 handle 1585: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1586 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1586 handle 1586: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1587 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1587 handle 1587: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1588 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1588 handle 1588: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1589 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1589 handle 1589: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1590 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1590 handle 1590: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1591 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1591 handle 1591: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1592 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1592 handle 1592: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1593 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1593 handle 1593: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1594 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1594 handle 1594: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1595 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1595 handle 1595: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1596 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1596 handle 1596: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1597 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1597 handle 1597: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1598 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1598 handle 1598: sfq perturb 10
tc class add dev ${LAN} parent 1:0 classid 1:1599 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN} parent 1:1599 handle 1599: sfq perturb 10


tc class add dev ${LAN1} parent 1:0 classid 1:72 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:72 handle 72: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:73 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:73 handle 73: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:74 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:74 handle 74: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:75 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:75 handle 75: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:76 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:76 handle 76: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:77 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:77 handle 77: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:78 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:78 handle 78: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:79 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:79 handle 79: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:710 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:710 handle 710: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:711 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:711 handle 711: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:712 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:712 handle 712: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:713 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:713 handle 713: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:714 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:714 handle 714: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:715 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:715 handle 715: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:716 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:716 handle 716: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:717 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:717 handle 717: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:718 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:718 handle 718: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:719 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:719 handle 719: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:720 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:720 handle 720: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:721 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:721 handle 721: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:722 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:722 handle 722: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:723 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:723 handle 723: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:724 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:724 handle 724: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:725 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:725 handle 725: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:726 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:726 handle 726: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:727 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:727 handle 727: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:728 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:728 handle 728: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:729 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:729 handle 729: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:730 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:730 handle 730: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:731 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:731 handle 731: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:732 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:732 handle 732: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:733 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:733 handle 733: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:734 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:734 handle 734: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:735 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:735 handle 735: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:736 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:736 handle 736: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:737 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:737 handle 737: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:738 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:738 handle 738: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:739 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:739 handle 739: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:740 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:740 handle 740: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:741 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:741 handle 741: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:742 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:742 handle 742: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:743 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:743 handle 743: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:744 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:744 handle 744: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:745 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:745 handle 745: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:746 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:746 handle 746: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:747 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:747 handle 747: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:748 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:748 handle 748: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:749 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:749 handle 749: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:750 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:750 handle 750: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:751 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:751 handle 751: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:752 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:752 handle 752: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:753 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:753 handle 753: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:754 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:754 handle 754: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:755 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:755 handle 755: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:756 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:756 handle 756: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:757 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:757 handle 757: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:758 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:758 handle 758: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:759 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:759 handle 759: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:760 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:760 handle 760: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:761 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:761 handle 761: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:762 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:762 handle 762: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:763 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:763 handle 763: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:764 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:764 handle 764: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:765 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:765 handle 765: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:766 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:766 handle 766: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:767 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:767 handle 767: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:768 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:768 handle 768: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:769 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:769 handle 769: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:770 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:770 handle 770: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:771 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:771 handle 771: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:772 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:772 handle 772: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:773 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:773 handle 773: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:774 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:774 handle 774: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:775 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:775 handle 775: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:776 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:776 handle 776: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:777 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:777 handle 777: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:778 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:778 handle 778: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:779 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:779 handle 779: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:780 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:780 handle 780: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:781 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:781 handle 781: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:782 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:782 handle 782: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:783 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:783 handle 783: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:784 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:784 handle 784: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:785 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:785 handle 785: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:786 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:786 handle 786: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:787 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:787 handle 787: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:788 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:788 handle 788: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:789 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:789 handle 789: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:790 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:790 handle 790: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:791 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:791 handle 791: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:792 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:792 handle 792: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:793 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:793 handle 793: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:794 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:794 handle 794: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:795 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:795 handle 795: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:796 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:796 handle 796: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:797 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:797 handle 797: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:798 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:798 handle 798: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:799 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN1} parent 1:799 handle 799: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:102 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:102 handle 102: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:103 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:103 handle 103: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:104 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:104 handle 104: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:105 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:105 handle 105: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:106 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:106 handle 106: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:107 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:107 handle 107: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:108 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:108 handle 108: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:109 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:109 handle 109: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1010 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1010 handle 1010: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1011 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1011 handle 1011: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1012 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1012 handle 1012: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1013 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1013 handle 1013: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1014 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1014 handle 1014: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1015 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1015 handle 1015: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1016 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1016 handle 1016: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1017 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1017 handle 1017: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1018 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1018 handle 1018: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1019 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1019 handle 1019: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1020 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1020 handle 1020: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1021 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1021 handle 1021: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1022 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1022 handle 1022: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1023 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1023 handle 1023: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1024 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1024 handle 1024: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1025 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1025 handle 1025: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1026 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1026 handle 1026: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1027 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1027 handle 1027: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1028 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1028 handle 1028: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1029 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1029 handle 1029: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1030 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1030 handle 1030: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1031 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1031 handle 1031: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1032 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1032 handle 1032: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1033 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1033 handle 1033: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1034 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1034 handle 1034: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1035 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1035 handle 1035: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1036 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1036 handle 1036: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1037 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1037 handle 1037: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1038 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1038 handle 1038: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1039 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1039 handle 1039: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1040 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1040 handle 1040: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1041 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1041 handle 1041: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1042 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1042 handle 1042: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1043 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1043 handle 1043: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1044 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1044 handle 1044: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1045 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1045 handle 1045: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1046 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1046 handle 1046: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1047 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1047 handle 1047: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1048 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1048 handle 1048: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1049 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1049 handle 1049: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1050 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1050 handle 1050: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1051 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1051 handle 1051: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1052 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1052 handle 1052: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1053 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1053 handle 1053: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1054 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1054 handle 1054: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1055 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1055 handle 1055: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1056 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1056 handle 1056: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1057 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1057 handle 1057: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1058 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1058 handle 1058: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1059 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1059 handle 1059: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1060 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1060 handle 1060: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1061 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1061 handle 1061: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1062 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1062 handle 1062: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1063 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1063 handle 1063: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1064 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1064 handle 1064: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1065 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1065 handle 1065: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1066 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1066 handle 1066: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1067 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1067 handle 1067: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1068 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1068 handle 1068: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1069 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1069 handle 1069: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1070 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1070 handle 1070: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1071 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1071 handle 1071: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1072 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1072 handle 1072: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1073 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1073 handle 1073: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1074 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1074 handle 1074: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1075 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1075 handle 1075: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1076 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1076 handle 1076: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1077 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1077 handle 1077: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1078 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1078 handle 1078: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1079 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1079 handle 1079: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1080 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1080 handle 1080: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1081 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1081 handle 1081: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1082 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1082 handle 1082: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1083 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1083 handle 1083: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1084 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1084 handle 1084: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1085 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1085 handle 1085: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1086 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1086 handle 1086: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1087 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1087 handle 1087: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1088 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1088 handle 1088: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1089 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1089 handle 1089: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1090 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1090 handle 1090: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1091 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1091 handle 1091: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1092 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1092 handle 1092: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1093 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1093 handle 1093: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1094 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1094 handle 1094: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1095 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1095 handle 1095: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1096 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1096 handle 1096: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1097 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1097 handle 1097: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1098 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1098 handle 1098: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1099 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1099 handle 1099: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:152 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:152 handle 152: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:153 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:153 handle 153: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:154 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:154 handle 154: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:155 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:155 handle 155: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:156 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:156 handle 156: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:157 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:157 handle 157: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:158 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:158 handle 158: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:159 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:159 handle 159: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1510 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1510 handle 1510: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1511 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1511 handle 1511: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1512 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1512 handle 1512: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1513 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1513 handle 1513: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1514 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1514 handle 1514: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1515 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1515 handle 1515: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1516 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1516 handle 1516: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1517 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1517 handle 1517: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1518 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1518 handle 1518: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1519 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1519 handle 1519: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1520 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1520 handle 1520: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1521 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1521 handle 1521: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1522 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1522 handle 1522: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1523 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1523 handle 1523: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1524 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1524 handle 1524: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1525 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1525 handle 1525: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1526 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1526 handle 1526: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1527 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1527 handle 1527: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1528 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1528 handle 1528: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1529 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1529 handle 1529: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1530 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1530 handle 1530: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1531 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1531 handle 1531: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1532 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1532 handle 1532: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1533 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1533 handle 1533: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1534 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1534 handle 1534: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1535 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1535 handle 1535: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1536 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1536 handle 1536: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1537 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1537 handle 1537: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1538 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1538 handle 1538: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1539 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1539 handle 1539: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1540 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1540 handle 1540: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1541 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1541 handle 1541: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1542 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1542 handle 1542: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1543 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1543 handle 1543: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1544 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1544 handle 1544: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1545 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1545 handle 1545: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1546 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1546 handle 1546: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1547 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1547 handle 1547: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1548 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1548 handle 1548: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1549 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1549 handle 1549: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1550 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1550 handle 1550: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1551 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1551 handle 1551: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1552 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1552 handle 1552: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1553 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1553 handle 1553: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1554 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1554 handle 1554: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1555 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1555 handle 1555: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1556 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1556 handle 1556: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1557 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1557 handle 1557: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1558 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1558 handle 1558: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1559 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1559 handle 1559: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1560 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1560 handle 1560: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1561 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1561 handle 1561: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1562 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1562 handle 1562: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1563 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1563 handle 1563: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1564 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1564 handle 1564: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1565 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1565 handle 1565: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1566 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1566 handle 1566: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1567 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1567 handle 1567: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1568 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1568 handle 1568: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1569 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1569 handle 1569: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1570 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1570 handle 1570: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1571 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1571 handle 1571: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1572 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1572 handle 1572: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1573 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1573 handle 1573: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1574 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1574 handle 1574: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1575 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1575 handle 1575: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1576 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1576 handle 1576: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1577 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1577 handle 1577: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1578 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1578 handle 1578: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1579 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1579 handle 1579: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1580 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1580 handle 1580: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1581 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1581 handle 1581: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1582 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1582 handle 1582: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1583 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1583 handle 1583: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1584 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1584 handle 1584: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1585 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1585 handle 1585: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1586 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1586 handle 1586: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1587 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1587 handle 1587: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1588 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1588 handle 1588: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1589 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1589 handle 1589: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1590 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1590 handle 1590: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1591 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1591 handle 1591: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1592 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1592 handle 1592: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1593 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1593 handle 1593: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1594 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1594 handle 1594: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1595 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1595 handle 1595: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1596 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1596 handle 1596: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1597 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1597 handle 1597: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1598 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1598 handle 1598: sfq perturb 10
tc class add dev ${LAN1} parent 1:0 classid 1:1599 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN1} parent 1:1599 handle 1599: sfq perturb 10


tc class add dev ${LAN2} parent 1:0 classid 1:72 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:72 handle 72: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:73 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:73 handle 73: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:74 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:74 handle 74: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:75 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:75 handle 75: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:76 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:76 handle 76: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:77 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:77 handle 77: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:78 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:78 handle 78: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:79 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:79 handle 79: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:710 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:710 handle 710: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:711 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:711 handle 711: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:712 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:712 handle 712: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:713 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:713 handle 713: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:714 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:714 handle 714: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:715 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:715 handle 715: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:716 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:716 handle 716: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:717 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:717 handle 717: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:718 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:718 handle 718: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:719 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:719 handle 719: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:720 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:720 handle 720: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:721 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:721 handle 721: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:722 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:722 handle 722: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:723 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:723 handle 723: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:724 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:724 handle 724: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:725 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:725 handle 725: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:726 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:726 handle 726: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:727 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:727 handle 727: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:728 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:728 handle 728: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:729 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:729 handle 729: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:730 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:730 handle 730: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:731 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:731 handle 731: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:732 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:732 handle 732: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:733 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:733 handle 733: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:734 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:734 handle 734: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:735 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:735 handle 735: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:736 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:736 handle 736: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:737 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:737 handle 737: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:738 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:738 handle 738: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:739 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:739 handle 739: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:740 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:740 handle 740: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:741 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:741 handle 741: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:742 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:742 handle 742: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:743 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:743 handle 743: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:744 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:744 handle 744: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:745 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:745 handle 745: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:746 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:746 handle 746: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:747 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:747 handle 747: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:748 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:748 handle 748: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:749 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:749 handle 749: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:750 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:750 handle 750: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:751 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:751 handle 751: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:752 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:752 handle 752: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:753 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:753 handle 753: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:754 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:754 handle 754: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:755 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:755 handle 755: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:756 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:756 handle 756: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:757 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:757 handle 757: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:758 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:758 handle 758: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:759 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:759 handle 759: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:760 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:760 handle 760: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:761 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:761 handle 761: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:762 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:762 handle 762: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:763 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:763 handle 763: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:764 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:764 handle 764: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:765 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:765 handle 765: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:766 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:766 handle 766: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:767 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:767 handle 767: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:768 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:768 handle 768: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:769 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:769 handle 769: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:770 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:770 handle 770: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:771 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:771 handle 771: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:772 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:772 handle 772: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:773 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:773 handle 773: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:774 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:774 handle 774: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:775 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:775 handle 775: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:776 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:776 handle 776: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:777 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:777 handle 777: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:778 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:778 handle 778: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:779 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:779 handle 779: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:780 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:780 handle 780: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:781 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:781 handle 781: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:782 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:782 handle 782: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:783 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:783 handle 783: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:784 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:784 handle 784: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:785 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:785 handle 785: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:786 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:786 handle 786: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:787 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:787 handle 787: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:788 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:788 handle 788: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:789 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:789 handle 789: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:790 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:790 handle 790: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:791 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:791 handle 791: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:792 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:792 handle 792: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:793 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:793 handle 793: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:794 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:794 handle 794: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:795 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:795 handle 795: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:796 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:796 handle 796: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:797 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:797 handle 797: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:798 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:798 handle 798: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:799 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit
tc qdisc add dev ${LAN2} parent 1:799 handle 799: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:102 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:102 handle 102: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:103 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:103 handle 103: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:104 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:104 handle 104: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:105 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:105 handle 105: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:106 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:106 handle 106: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:107 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:107 handle 107: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:108 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:108 handle 108: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:109 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:109 handle 109: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1010 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1010 handle 1010: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1011 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1011 handle 1011: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1012 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1012 handle 1012: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1013 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1013 handle 1013: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1014 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1014 handle 1014: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1015 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1015 handle 1015: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1016 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1016 handle 1016: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1017 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1017 handle 1017: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1018 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1018 handle 1018: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1019 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1019 handle 1019: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1020 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1020 handle 1020: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1021 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1021 handle 1021: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1022 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1022 handle 1022: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1023 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1023 handle 1023: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1024 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1024 handle 1024: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1025 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1025 handle 1025: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1026 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1026 handle 1026: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1027 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1027 handle 1027: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1028 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1028 handle 1028: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1029 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1029 handle 1029: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1030 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1030 handle 1030: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1031 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1031 handle 1031: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1032 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1032 handle 1032: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1033 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1033 handle 1033: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1034 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1034 handle 1034: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1035 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1035 handle 1035: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1036 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1036 handle 1036: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1037 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1037 handle 1037: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1038 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1038 handle 1038: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1039 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1039 handle 1039: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1040 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1040 handle 1040: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1041 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1041 handle 1041: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1042 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1042 handle 1042: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1043 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1043 handle 1043: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1044 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1044 handle 1044: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1045 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1045 handle 1045: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1046 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1046 handle 1046: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1047 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1047 handle 1047: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1048 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1048 handle 1048: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1049 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1049 handle 1049: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1050 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1050 handle 1050: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1051 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1051 handle 1051: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1052 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1052 handle 1052: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1053 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1053 handle 1053: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1054 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1054 handle 1054: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1055 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1055 handle 1055: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1056 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1056 handle 1056: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1057 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1057 handle 1057: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1058 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1058 handle 1058: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1059 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1059 handle 1059: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1060 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1060 handle 1060: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1061 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1061 handle 1061: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1062 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1062 handle 1062: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1063 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1063 handle 1063: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1064 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1064 handle 1064: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1065 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1065 handle 1065: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1066 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1066 handle 1066: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1067 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1067 handle 1067: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1068 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1068 handle 1068: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1069 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1069 handle 1069: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1070 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1070 handle 1070: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1071 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1071 handle 1071: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1072 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1072 handle 1072: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1073 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1073 handle 1073: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1074 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1074 handle 1074: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1075 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1075 handle 1075: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1076 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1076 handle 1076: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1077 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1077 handle 1077: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1078 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1078 handle 1078: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1079 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1079 handle 1079: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1080 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1080 handle 1080: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1081 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1081 handle 1081: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1082 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1082 handle 1082: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1083 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1083 handle 1083: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1084 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1084 handle 1084: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1085 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1085 handle 1085: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1086 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1086 handle 1086: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1087 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1087 handle 1087: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1088 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1088 handle 1088: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1089 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1089 handle 1089: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1090 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1090 handle 1090: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1091 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1091 handle 1091: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1092 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1092 handle 1092: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1093 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1093 handle 1093: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1094 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1094 handle 1094: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1095 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1095 handle 1095: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1096 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1096 handle 1096: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1097 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1097 handle 1097: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1098 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1098 handle 1098: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1099 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1099 handle 1099: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:152 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:152 handle 152: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:153 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:153 handle 153: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:154 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:154 handle 154: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:155 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:155 handle 155: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:156 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:156 handle 156: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:157 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:157 handle 157: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:158 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:158 handle 158: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:159 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:159 handle 159: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1510 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1510 handle 1510: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1511 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1511 handle 1511: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1512 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1512 handle 1512: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1513 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1513 handle 1513: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1514 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1514 handle 1514: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1515 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1515 handle 1515: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1516 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1516 handle 1516: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1517 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1517 handle 1517: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1518 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1518 handle 1518: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1519 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1519 handle 1519: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1520 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1520 handle 1520: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1521 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1521 handle 1521: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1522 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1522 handle 1522: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1523 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1523 handle 1523: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1524 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1524 handle 1524: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1525 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1525 handle 1525: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1526 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1526 handle 1526: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1527 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1527 handle 1527: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1528 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1528 handle 1528: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1529 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1529 handle 1529: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1530 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1530 handle 1530: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1531 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1531 handle 1531: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1532 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1532 handle 1532: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1533 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1533 handle 1533: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1534 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1534 handle 1534: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1535 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1535 handle 1535: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1536 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1536 handle 1536: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1537 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1537 handle 1537: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1538 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1538 handle 1538: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1539 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1539 handle 1539: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1540 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1540 handle 1540: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1541 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1541 handle 1541: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1542 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1542 handle 1542: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1543 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1543 handle 1543: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1544 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1544 handle 1544: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1545 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1545 handle 1545: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1546 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1546 handle 1546: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1547 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1547 handle 1547: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1548 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1548 handle 1548: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1549 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1549 handle 1549: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1550 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1550 handle 1550: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1551 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1551 handle 1551: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1552 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1552 handle 1552: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1553 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1553 handle 1553: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1554 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1554 handle 1554: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1555 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1555 handle 1555: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1556 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1556 handle 1556: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1557 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1557 handle 1557: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1558 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1558 handle 1558: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1559 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1559 handle 1559: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1560 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1560 handle 1560: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1561 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1561 handle 1561: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1562 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1562 handle 1562: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1563 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1563 handle 1563: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1564 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1564 handle 1564: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1565 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1565 handle 1565: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1566 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1566 handle 1566: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1567 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1567 handle 1567: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1568 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1568 handle 1568: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1569 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1569 handle 1569: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1570 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1570 handle 1570: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1571 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1571 handle 1571: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1572 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1572 handle 1572: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1573 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1573 handle 1573: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1574 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1574 handle 1574: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1575 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1575 handle 1575: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1576 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1576 handle 1576: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1577 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1577 handle 1577: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1578 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1578 handle 1578: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1579 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1579 handle 1579: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1580 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1580 handle 1580: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1581 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1581 handle 1581: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1582 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1582 handle 1582: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1583 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1583 handle 1583: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1584 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1584 handle 1584: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1585 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1585 handle 1585: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1586 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1586 handle 1586: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1587 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1587 handle 1587: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1588 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1588 handle 1588: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1589 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1589 handle 1589: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1590 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1590 handle 1590: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1591 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1591 handle 1591: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1592 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1592 handle 1592: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1593 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1593 handle 1593: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1594 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1594 handle 1594: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1595 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1595 handle 1595: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1596 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1596 handle 1596: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1597 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1597 handle 1597: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1598 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1598 handle 1598: sfq perturb 10
tc class add dev ${LAN2} parent 1:0 classid 1:1599 est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit
tc qdisc add dev ${LAN2} parent 1:1599 handle 1599: sfq perturb 10