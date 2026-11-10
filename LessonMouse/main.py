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
        self.__connect = sqlite3.connect(self.__db_path)
        self.__cursor = self.__connect.cursor()

        os.makedirs(self.format_path('tmp'), exist_ok=True)

    def __get_pwd(self) -> Path:
        return Path(__file__).resolve().parent

    def format_path(self, name) -> str:
        return self.__get_pwd() / name

    def recognize(self, path: str):
        result, _ = self.engine(path)
        if not result:
            return

        return '\n'.join([line[1] for line in result])

    def on_click(self, x, y, button, pressed):
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
        mss.tools.to_png(screenshot.rgb, screenshot.size, output=url)
        res = self.recognize(path=url)
        print(res)


window = MouseWindow()
with mouse.Listener(on_click=window.on_click) as listener:
    listener.join()
