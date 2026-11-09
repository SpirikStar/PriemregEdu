import os 
from bs4 import BeautifulSoup
from everythingtohtml import EverythingToHtml

eth = EverythingToHtml()

result = eth.convert("/Users/spirik/Documents/GitHub/PriemregEdu/LessonReestrSpo/09.02.07 ПООП Информационные системы и программирование.doc")
with open('test.html', "w", encoding="utf-8") as file:
    file.write(result.html)
print(result.html)