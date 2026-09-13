#!/bin/python3
import requests
import gspread

from gspread import Client, Spreadsheet, Worksheet

from avaribles import API_TOKEN

SPREADSHEET_URL = ""
headers = {"x-vsaas-service-api-key": API_TOKEN}
remove_list = ['IP', '#N/A', '', 'MAC']
header_row = ["id", "custom_name", "login", "balance", "enabled", "MAC", "IP"]


# получаем данные по API, парсим, пересозаём таблицу, заносим по ключам, возвращаем список со значениями.
def test(test_ws: Worksheet):
    response = requests.get("https://api.dvor24.com/api/v2/users", headers=headers)
    data = response.json()
    par_data = data["result"]["users"]
    rows = [header_row]
    for key in par_data:  # type: dict
        # print('KEY', key)
        rows.append([
            key.get(head, "")
            for head in header_row
        ])
    count = 1
    for i in rows[1:]:
        count += 1
        z = f'=VLOOKUP($A{count};IP_ADRESS!$A$1:$D$256;4;0)'
        y = f'=XLOOKUP($A{count}; IP_ADRESS!$A:A; IP_ADRESS!C:C;)'
        i.insert(5, y)
        i.insert(6, z)
    # print("!!!!!!", rows)
    test_ws.update(rows, value_input_option="USER_ENTERED")

    return rows


def acces_list(acces_list_ws: Worksheet, rows):
    acces_list_ws.resize(rows=1, cols=7)
    acces = [header_row]
    for i in rows[1:]:
        j = float(i[3])
        if j > 0:
            acces.append(i)
    count = 1
    for i in acces[1:]:
        count += 1
        z = f'=VLOOKUP($A{count};IP_ADRESS!$A$1:$D$256;4;0)'
        y = f'=XLOOKUP($A{count}; IP_ADRESS!$A:A; IP_ADRESS!C:C;)'
        i.insert(5, y)
        del i[6:]
        i.insert(6, z)
    acces_list_ws.update(acces, value_input_option="USER_ENTERED")
    acces_values = acces_list_ws.col_values(6)

    for key in remove_list:
        while key in acces_values:
            acces_values.remove(key)
    with open('acces.txt', 'w') as filehandle:
        for ip in acces_values:
            filehandle.write('%s\n' % ip)


def denied_list(denied_list_ws: Worksheet, rows):
    denied_list_ws.resize(rows=1, cols=7)
    denied = [header_row]
    for i in rows[1:]:
        # print("i3", i[3])
        j = float(i[3])
        # print(j)
        if j <= 0:
            denied.append(i)
    # for a in denied:
    #     print("denied", a)
    count = 1
    for i in denied[1:]:
        count += 1
        z = f'=VLOOKUP($A{count};IP_ADRESS!$A$1:$D$256;4;0)'
        y = f'=XLOOKUP($A{count}; IP_ADRESS!$A:A; IP_ADRESS!C:C;)'
        i.insert(5, y)
        del i[6:]
        i.insert(6, z)
    denied_list_ws.update(denied, value_input_option="USER_ENTERED")
    denied_values = denied_list_ws.col_values(6)
    for key in remove_list:
        while key in denied_values:
            denied_values.remove(key)
            # print('deleted', key)
        # else:
        #     print('no values', key)
    with open('denied.txt', 'w') as filehandle:
        for ip in denied_values:
            filehandle.write('%s\n' % ip)


def tarif_list(ws: Worksheet):
    tarif_list1 = ws.get_all_records()
    ws.resize(len(tarif_list1) + 2, cols=6)
    t500 = []
    t800 = []
    t1000 = []
    count = 1
    count1 = 1
    count2 = 1
    for key in tarif_list1:
        t5 = ('70mbit')
        t8 = ('100mbit')
        t10 = ('150mbit')
        k = key['tarif']
        if k == t5:
            count += 1
            x = (key['IP'])
            y = f'add 70mbit {x} skbprio 1:7{count}'
            t500.append(y)
            # print(t500)
        if k == t8:
            count1 += 1
            t = (key['IP'])
            u = f'add 70mbit {t} skbprio 1:10{count1}'
            t800.append(u)
        if k == t10:
            count2 += 1
            q = (key['IP'])
            w = f'add 70mbit {q} skbprio 1:15{count2}'
            t1000.append(w)
        # else :
        #     print(key['id'], key['IP'], 'тариф не установлен')
    with open('Tarif_70mbit.txt', 'w') as filehandle:
        for ip in t500:
            filehandle.write('%s\n' % ip)
    with open('Tarif_70mbit.txt', 'a') as filehandle:
        for ip in t800:
            filehandle.write('%s\n' % ip)
    with open('Tarif_70mbit.txt', 'a') as filehandle:
        for ip in t1000:
            filehandle.write('%s\n' % ip)


def main():
    gc: Client = gspread.service_account("")
    sh: Spreadsheet = gc.open_by_url(SPREADSHEET_URL)
    ws1 = sh.sheet1
    test_ws = sh.worksheet("Dvor24")
    acces_list_ws = sh.worksheet("acces_list")
    denied_list_ws = sh.worksheet("denied_list")
    tarif_list_ws = sh.worksheet("IP_ADRESS")
    tarif_list(tarif_list_ws)
    test(test_ws)
    rows = test(test_ws)
    acces_list(acces_list_ws, rows)
    denied_list(denied_list_ws, rows)


if __name__ == '__main__':
    main()
