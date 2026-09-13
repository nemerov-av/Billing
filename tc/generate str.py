LAN = '${LAN2}'


for i in range(2, 100):
    x = f'tc class add dev {LAN} parent 1:0 classid 1:7{i} est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 70mbit'
    y = f'tc qdisc add dev {LAN} parent 1:7{i} handle 7{i}: sfq perturb 10'
    print(x, y, sep='\n')

for i in range(2, 100):
    x = f'tc class add dev {LAN} parent 1:0 classid 1:10{i} est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 100mbit'
    y = f'tc qdisc add dev {LAN} parent 1:10{i} handle 10{i}: sfq perturb 10'
    print(x, y, sep='\n')

for i in range(2, 100):
    x = f'tc class add dev {LAN} parent 1:0 classid 1:15{i} est 1sec 8sec hfsc sc umax 1500b dmax 10ms rate 10mbit ul rate 400mbit'
    y = f'tc qdisc add dev {LAN} parent 1:15{i} handle 15{i}: sfq perturb 10'
    print(x, y, sep='\n')