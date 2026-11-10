from pynput import mouse
import mss
import mss.tools
import time
from rapidocr_onnxruntime import RapidOCR
from pathlib import Path
import sqlite3
import os


class MouseWindow:
    def __init__(self):
        self.crop_size = 200
        self.sct = mss.mss()
        self.engine = RapidOCR()
        self.__db_path = self.format_path('base.db')

        self.__create_table()

        os.makedirs(self.format_path('tmp'), exist_ok=True)

    def __get_pwd(self) -> Path:
        return Path(__file__).resolve().parent

    def __connect_db(self):
        connect = sqlite3.connect(self.__db_path)
        return connect, connect.cursor()

    def __custom_execute(self, sql: str, parameters: tuple = ()):
        # TODO: Выявить возможные проблемы и устранить
        connect, cursor = self.__connect_db()
        cursor.execute(sql, parameters)
        if 'CREATE TABLE' not in sql:
            connect.commit()
        connect.close()

    def __create_table(self):
        self.__custom_execute('''
            CREATE TABLE IF NOT EXISTS screens (
                image BLOB NOT NULL,
                content TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
            )
        ''')

    def format_path(self, name) -> str:
        return self.__get_pwd() / name

    def recognize(self, path: str):
        result, _ = self.engine(path)
        if not result:
            return

        return '\n'.join([line[1] for line in result])

    def on_click(self, x, y, button, pressed):
        # TODO: Содержимое функции разбить на отдельные методы
        if not pressed or button != mouse.Button.left:
            return

        half = self.crop_size // 2
        region = {
            "left": x - half,
            "top": y - half,
            "width": self.crop_size,
            "height": self.crop_size
        }

        screenshot = self.sct.grab(region)

        url = self.format_path(f'tmp/{time.time()}-{x}-{y}.png')
        #TODO: Сжать максимально изображение (level 9, максималка). Но необходимо проанализировать, не повлияет ли это на качество распознавания.
        mss.tools.to_png(screenshot.rgb, screenshot.size, output=url)
        res_recognize = self.recognize(path=url)
        with open(url, 'rb') as file:
            image_byte = file.read()
        #TODO: После сохранения в БД необходимо удалять фото из tmp
        self.__custom_execute(
            'INSERT INTO screens (image, content) VALUES (?, ?)',
            (sqlite3.Binary(image_byte), res_recognize)
        )


#TODO: Ускорить, проверить на легаси, попробовать перевести распознавание в потоки.
#TODO: Сделать рефакторинг кода
window = MouseWindow()
with mouse.Listener(on_click=window.on_click) as listener:
    listener.join()
