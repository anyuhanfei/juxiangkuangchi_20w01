import requests
import json
import pymysql
import time

# 数据库连接
conn = pymysql.connect(
    host='47.242.55.108',
    port=3306,
    user='www',
    password='YMpApFDx2dmNs2Pa',
    db='www',
    charset='utf8'
)
cursor = conn.cursor()

# url
b_url = "https://kline.zbg.com/api/data/v1/tickers?isUseMarketName=true"

headers = {"user-agent": "user-agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.87 Safari/537.36"}

cookies = {
    "userId": "eyJpdiI6InBuQ3VZWmVURWQ4WEZYYXpZYWNMZnc9PSIsInZhbHVlIjoiRWhiVUtpQUJseUVXZnVFNUVzbitSbWNIYWU1RDNLMVNxd29uQmNROWFwT3ZObEUzWHpYRmFMZjdwQmd3Tmh6SW5uYXczcEs5UW9DVzllYnRsUVFIdUE9PSIsIm1hYyI6IjIzMTE5YTFjMTRkZWNkNmI2ZGM5MTA3ZDZmMmEzZmQ2ZDcwMTEyMmRhN2NjOWZhMjAzMDgzNjUwODIzNjM0YjMifQ%3D%3D",
    "is_refresh": "eyJpdiI6InVZNXFcL0d0c0wyWEQwT1lrbXpCdmt3PT0iLCJ2YWx1ZSI6IjM1WmVtYXFVNDBoWmVsd0NhZ3Faenc9PSIsIm1hYyI6IjFmMjMxN2FmZmNjMDY1MTNkYTZiZTUwNGI0ZTAxZDQ0ODFhODk5MWZiNzdiMjY1MjA2MGU3YjU0Y2IxOTBmOTQifQ%3D%3D",
    "Hm_lvt_3b668291b682e6dc69686a3e2445e11d": "1573441366",
    "Hm_lpvt_3b668291b682e6dc69686a3e2445e11d": "1573441380"
}

# 币值
b_res = requests.get(b_url)
b_list_res = json.loads(b_res.content)
btc_usdt = b_list_res['datas']['BTC_USDT']
eth_usdt = b_list_res['datas']['ETH_USDT']
fil_usdt = b_list_res['datas']['FIL_USDT']
eos_usdt = b_list_res['datas']['EOS_USDT']
trx_usdt = b_list_res['datas']['TRX_USDT']

btc_usdt_select_sql = "select * from auto_value where coin='BTC'"
cursor.execute(btc_usdt_select_sql)
btc_usdt_select_sql_res = dict(zip([k[0] for k in cursor.description], cursor.fetchall()))
if btc_usdt_select_sql_res:
    btc_usdt_update_sql = "update auto_value set hight_number='%s', last_number='%s', low_number='%s', vol='%s', insert_time='%s' where coin='%s'"
    btc_usdt_update_sql = btc_usdt_update_sql % (btc_usdt[2], btc_usdt[1], btc_usdt[3], btc_usdt[5], time.time(), 'BTC')
    btc_usdt_update_res = cursor.execute(btc_usdt_update_sql)
    if btc_usdt_update_res == 1:
        conn.commit()

eth_usdt_select_sql = "select * from auto_value where coin='ETH'"
cursor.execute(eth_usdt_select_sql)
eth_usdt_select_sql_res = dict(zip([k[0] for k in cursor.description], cursor.fetchall()))
if eth_usdt_select_sql_res:
    eth_usdt_update_sql = "update auto_value set hight_number='%s', last_number='%s', low_number='%s', vol='%s', insert_time='%s' where coin='%s'"
    eth_usdt_update_sql = eth_usdt_update_sql % (eth_usdt[2], eth_usdt[1], eth_usdt[3], eth_usdt[5], time.time(), 'ETH')
    eth_usdt_update_res = cursor.execute(eth_usdt_update_sql)
    if eth_usdt_update_res == 1:
        conn.commit()

fil_usdt_select_sql = "select * from auto_value where coin='FIL'"
cursor.execute(fil_usdt_select_sql)
fil_usdt_select_sql_res = dict(zip([k[0] for k in cursor.description], cursor.fetchall()))
if fil_usdt_select_sql_res:
    fil_usdt_update_sql = "update auto_value set hight_number='%s', last_number='%s', low_number='%s', vol='%s', insert_time='%s' where coin='%s'"
    fil_usdt_update_sql = fil_usdt_update_sql % (fil_usdt[2], fil_usdt[1], fil_usdt[3], fil_usdt[5], time.time(), 'FIL')
    fil_usdt_update_res = cursor.execute(fil_usdt_update_sql)
    if fil_usdt_update_res == 1:
        conn.commit()

eos_usdt_select_sql = "select * from auto_value where coin='EOS'"
cursor.execute(eos_usdt_select_sql)
eos_usdt_select_sql_res = dict(zip([k[0] for k in cursor.description], cursor.fetchall()))
if eos_usdt_select_sql_res:
    eos_usdt_update_sql = "update auto_value set hight_number='%s', last_number='%s', low_number='%s', vol='%s', insert_time='%s' where coin='%s'"
    eos_usdt_update_sql = eos_usdt_update_sql % (eos_usdt[2], eos_usdt[1], eos_usdt[3], eos_usdt[5], time.time(), 'EOS')
    eos_usdt_update_res = cursor.execute(eos_usdt_update_sql)
    if eos_usdt_update_res == 1:
        conn.commit()

trx_usdt_select_sql = "select * from auto_value where coin='TRX'"
cursor.execute(trx_usdt_select_sql)
trx_usdt_select_sql_res = dict(zip([k[0] for k in cursor.description], cursor.fetchall()))
if trx_usdt_select_sql_res:
    trx_usdt_update_sql = "update auto_value set hight_number='%s', last_number='%s', low_number='%s', vol='%s', insert_time='%s' where coin='%s'"
    trx_usdt_update_sql = trx_usdt_update_sql % (trx_usdt[2], trx_usdt[1], trx_usdt[3], trx_usdt[5], time.time(), 'TRX')
    trx_usdt_update_res = cursor.execute(trx_usdt_update_sql)
    if trx_usdt_update_res == 1:
        conn.commit()
