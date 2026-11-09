from pynput import mouse
import mss
import mss.tools
import time
from rapidocr_onnxruntime import RapidOCR
from pathlib import Path


class MouseWindow:
    def __init__(self):
        self.crop_size = 200
        self.sct = mss.mss()
        self.engine = RapidOCR()

    def get_pwd(self) -> Path:
        return Path(__file__).resolve().parent

    def recognize(self, path: str):
        result, _ = self.engine(path)
        if not result:
            return

        return [line[1] for line in result]
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

        url = f'{self.get_pwd()}/screen/{time.time()}-{x}-{y}.png'
        mss.tools.to_png(screenshot.rgb, screenshot.size, output=url)
        res = self.recognize(path=url)
        print(res) 
        # TODO: Возращать нужно предложение со всеми красными строками в место массива. 
        # TODO: Изучить https://github.com/RapidAI/RapidOCR
        # TODO: Узнать можно ли улучшить качество распознования 
        # TODO: Посмотреть аналоги
        # TODO: Сохранять в json файл формат: [{'путь': '', 'context': ''}, ...]

window = MouseWindow()
with mouse.Listener(on_click=window.on_click) as listener:
    listener.join()
