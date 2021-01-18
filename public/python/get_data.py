import requests
import json
import pymysql
import time

# 数据库连接
conn = pymysql.connect(
    host='127.0.0.1',
    port=3306,
    user='root',
    password='root',
    db='炬象矿池_21w01',
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

btc_usdt_select_sql = "select * from auto_value where coin='比特币'"
cursor.execute(btc_usdt_select_sql)
btc_usdt_select_sql_res = dict(zip([k[0] for k in cursor.description], cursor.fetchall()))
if btc_usdt_select_sql_res:
    btc_usdt_update_sql = "update auto_value set hight_number='%s', last_number='%s', low_number='%s', vol='%s', insert_time='%s' where coin='%s'"
    btc_usdt_update_sql = btc_usdt_update_sql % (btc_usdt[2], btc_usdt[1], btc_usdt[3], btc_usdt[5], time.time(), '比特币')
    btc_usdt_update_res = cursor.execute(btc_usdt_update_sql)
    if btc_usdt_update_res == 1:
        conn.commit()

eth_usdt_select_sql = "select * from auto_value where coin='以太坊'"
cursor.execute(eth_usdt_select_sql)
eth_usdt_select_sql_res = dict(zip([k[0] for k in cursor.description], cursor.fetchall()))
if eth_usdt_select_sql_res:
    eth_usdt_update_sql = "update auto_value set hight_number='%s', last_number='%s', low_number='%s', vol='%s', insert_time='%s' where coin='%s'"
    eth_usdt_update_sql = eth_usdt_update_sql % (eth_usdt[2], eth_usdt[1], eth_usdt[3], eth_usdt[5], time.time(), '以太坊')
    eth_usdt_update_res = cursor.execute(eth_usdt_update_sql)
    if eth_usdt_update_res == 1:
        conn.commit()
