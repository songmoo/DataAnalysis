# -*- coding: utf-8 -*-
import requests as rq
from bs4 import BeautifulSoup
import pandas as pd
import mysql.connector

def crawling(key, pages):
    
    title = []
    price_sales = []
    price_ori = []
    company = []
    url = "http://browse.auction.co.kr/search?keyword={}&itemno=&nickname=&encKeyword={}&arraycategory=&frm=&dom=auction&isSuggestion=No&retry=&k=16&p={}"
    
    
    for i in range(pages):
        res = rq.get(url.format(key, key, i+1))
        html = res.content
        soup = BeautifulSoup(html, 'lxml')
        soup_item = soup.find_all("div", class_="section--itemcard")
        num = len(soup_item)
        for i in range(0, num):
            # 상품명
            soup_title = soup_item[i].find("span", class_="text--title")
            #print(soup_title)
            if soup_title is not None:
                title_txt = soup_title.text
                title.append(title_txt)
            else:
                title.append("")
    
            # 상품가격(할인적용금액)
            soup_price = soup_item[i].find("strong", class_="text--price_seller")
            #print(soup_price)
            if soup_price is not None:
                price_txt = soup_price.text
                price_sales.append(price_txt)
            else:
                price_sales.append("")
    
            # 상품가격(원래 금액)
            soup_price_ori = soup_item[i].find("strong", class_="text--price_original")
            #print(soup_price_ori)
            if soup_price_ori is not None:
                price_ori_txt = soup_price_ori.text
                price_ori.append(price_ori_txt)   
            else:
                price_ori.append("")
    
            # 회사
            soup_company = soup_item[i].find("span", class_="text")
            #print(soup_company)
            if soup_company is not None:
                soup_company_txt = soup_company.text
                company.append(soup_company_txt)   
            else:
                company.append("스마일배송")

    title1 = pd.Series(title)
    price_sales1 = pd.Series(price_sales)
    price_ori1 = pd.Series(price_ori)
    company_name = pd.Series(company)
    
    dat = pd.DataFrame({ "title" : title , 
                       "price_sales" : price_sales, 
                       "price_origin" : price_ori,
                       "company_name" : company_name }, columns=['title','price_sales','price_origin', "company_name"] )

    mydb = mysql.connector.connect(
            host='localhost',
            user = 'root',
            passwd='qwer1234',
            database = 'mydatabase'
            )
    
    
    mycursor = mydb.cursor()
    mycursor.execute("CREATE TABLE IF NOT EXISTS tableb (title VARCHAR(255), price_sales VARCHAR(64), price_origin VARCHAR(64),company_name VARCHAR(64))")

        
    for row in dat.values.tolist():
        line = row
        mycursor.execute("INSERT INTO tableb(title, price_sales, price_origin, company_name) VALUES(%s, %s, %s, %s)", line)
    
    mydb.commit()
    dat.to_csv("company_info.csv", index=False, encoding="EUCKR")
    
    print("Done")
