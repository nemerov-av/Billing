#!/bin/python3
import requests
import gspread
import re
from gspread import Client, Spreadsheet, Worksheet

from avaribles import API_TOKEN

SPREADSHEET_URL = ""
headers = {"x-vsaas-service-api-key": API_TOKEN}


def mac_ip_pars():
    file = open("/var/lib/dhcp/dhcpd.leases")
    file_data = file.read()
    lines = file_data.splitlines()
    lines_clear = list()
    for i in lines[6:]:
        j = re.sub('|\?|\!|\;|\}|\{|', '', i)
        j = j.lstrip()
        j = j.rstrip()
        lines_clear.append(j)
        # print(j)
    # print(lines_clear)
    data = []
    line = []
    data_ip_mac = {}
    data_ip = []
    data_mac = []
    word = ["lease", "hardware ethernet"]
    for line in lines_clear:
        for w in word:
            if w in line:
                data.append(line)
                # print(line)
    for ip in data:
        # print(ip)
        if 'lease' in ip:
            l = re.sub('|lease|\'|', '', ip)
            l = l.lstrip()
            l = l.rstrip()
            data_ip.append(l)
        else:
            k = re.sub('hardware ethernet', '', ip)
            k = k.lstrip()
            k = k.rstrip()
            data_mac.append(k)
    data_ip_mac = dict(zip(data_mac, data_ip))
    # print(data_ip_mac)
    # print(lines[5:])
    return data_ip_mac

def mac_ip_DHCP(mac_ip_DHCP_ws: Worksheet, data_ip_mac):
    mac_ip_DHCP_ws.resize(rows=1, cols=5)
    header_row = ["id", "custom_name", "login", "MAC", "IP"]
    row = [header_row]
    # print(data_ip_mac)

    count = 1
    for key in data_ip_mac:     #type: dict
        line = []
        count += 1
        z = f'=XLOOKUP($D{count}; IP_ADRESS!$C:C; IP_ADRESS!A:A;)'
        line.append(z)
        y = f'=XLOOKUP($D{count}; IP_ADRESS!$C:C; IP_ADRESS!B:B;)'
        line.append(y)
        line.append("")
        line.append(key)
        line.append(data_ip_mac[key])
        row.append(line)


    mac_ip_DHCP_ws.update(row, value_input_option="USER_ENTERED")
    # print(row)


def main():
    gc: Client = gspread.service_account("")
    sh: Spreadsheet = gc.open_by_url(SPREADSHEET_URL)
    mac_ip_DHCP_ws = sh.worksheet("mac_ip_DHCP")
    mac_ip_pars()
    data_ip_mac=(mac_ip_pars())
    mac_ip_DHCP(mac_ip_DHCP_ws, data_ip_mac)


if __name__ == '__main__':
    main()
