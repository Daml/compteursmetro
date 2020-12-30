#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# usage: combine.py YYYY-MM-DD
#
# Query params :
#
# * idOrganisme (int) Identifiant client
# * idPdc (mixed) Indentifiant Point De Comptage
# * fin/debut (str:dd/mm/YYYY)
# * interval (int) :
#    4 : daily
#    5 : weekly
#    6 : monthly
# * pratiques (str) semicolon separated list of directions
#


import os
import csv
import ssl
import sys
import json
import time
import http.client
from urllib.parse import urlencode
from datetime import datetime,date,timedelta

delta = timedelta(days=1)

headers = {
    'Pragma': 'no-cache',
    'Cache-Control': 'no-cache',
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36',
    'Accept': 'text/plain, */*; q=0.01',
    'Accept-Language': 'en-US,en;q=0.9',
    'Sec-Fetch-Site': 'cross-site',
    'Sec-Fetch-Mode': 'cors',
    'Sec-Fetch-Dest': 'empty',
    'Origin': 'https://www.eco-public.com',
    'Referer': 'https://www.eco-public.com/',
}

def query(idPdc, first, end, flow):
    query = {
        'idOrganisme': 120,
        'idPdc': idPdc,
        'fin': end.strftime('%d/%m/%Y'),
        'debut': first.strftime('%d/%m/%Y'),
        'interval': 4,
        'flowIds': flow,
    }
    #conn = http.client.HTTPConnection("localhost:9583")
    conn = http.client.HTTPSConnection("www.eco-visio.net", context=ssl._create_unverified_context())
    url = '/api/aladdin/1.0.0/pbl/publicwebpageplus/data/%s?%s' % (idPdc, urlencode(query))
    conn.request("GET", url, None, headers)
    resp = conn.getresponse()

    if resp.status != 200:
        raise Exception('Incorrect HTTP Response (%d)' % resp.status)

    return json.loads(str(resp.read(), 'utf-8'))

def update(idPdc, flows = [], inDef = [], outDef = []):
    print("process !", idPdc)
    dailyFile = open("series/%s/daily.csv" % idPdc, "r")

    # Go to end of file and look for newline
    fileEnd = filePos = dailyFile.seek(0, os.SEEK_END)
    filePos -= 1

    while (filePos > 0):
        filePos -= 1
        dailyFile.seek(filePos)
        nc = dailyFile.read(1)
        if (nc == "\n"):
            break

    if (filePos + 11 > fileEnd):
        raise Exception("Last line detection failed")

    # Read last date, prepare query range
    first = datetime.strptime(dailyFile.read(10), '%Y-%m-%d') + delta
    end = datetime.today() - delta

    # Prepare data structure
    data = {}
    step = first
    while (step < end):
        iso = step.isocalendar()
        data[step.strftime('%Y-%m-%d')] = {'week': iso[1], 'dow': iso[2], 'sources': {}}
        step += delta

    # Iterate over flow, query API and store results
    for flow in flows:
        print("PDC:%s / Flow:%s" % (idPdc, flow))
        payload = query(idPdc, first, end + delta, flow)

        if len(payload) != len(data):
            raise Exception('Inconsistent JSON response count')

        for item in payload:
            key = datetime.strptime(item[0], '%m/%d/%Y').strftime('%Y-%m-%d')
            data[key]['sources'][flow] = int(item[1])

    dailyFile.close()
    dailyFile = open("series/%s/daily.csv" % idPdc, "a")
    output = csv.writer(dailyFile, delimiter=",")

    for key in data:
        if len(data[key]['sources']) != len(flows):
            raise Exception('Incomplete data sources')

        inSum = outSum = 0
        for ref in inDef:
            inSum += data[key]['sources'][ref]
        for ref in outDef:
            outSum += data[key]['sources'][ref]

        line = [
            key,
            data[key]['week'],
            data[key]['dow'],
            None,
            inSum + outSum,
            inSum,
            outSum,
        ]

        for flow in flows:
            line.append(data[key]['sources'][flow])

        output.writerow(line)

    dailyFile.close()

def main():
    param = None
    if len(sys.argv) > 1:
        param = sys.argv[1]

    with open('sources.geojson') as cfgFile:
        config = json.load(cfgFile)

    for sensor in config['features']:
        if param and (param != str(sensor['properties']['id'])):
            continue

        update(
            sensor['properties']['id'],
            sensor['properties']['pratiques'],
            sensor['properties']['in'],
            sensor['properties']['out']
        )

if __name__ == "__main__":
    main()

