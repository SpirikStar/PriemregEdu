from pynput import mouse
from PIL import ImageGrab # ! Убарть импорт
import time
import mss
import mss.tools

class MouseWindow:
    def __init__(self):
        self.crop_size = 200
        self.sct = mss.mss()

    def on_click(self, x, y, button, pressed):
        if not pressed:
            return
        if button != mouse.Button.left:
            return

        # TODO: Заменить ImageGrab на self.sct.grab({"left": .., "top": .., "right": .., "bottom": ..})
        screennshot = ImageGrab.grab(all_screens=True)
        left = max(0, x - self.crop_size // 2)
        top = max(0, y - self.crop_size // 2)

        right = min(screennshot.width, x + self.crop_size // 2)
        bottom = min(screennshot.height, y + self.crop_size // 2)
        
        # TODO: Убарать crop
        cropped = screennshot.crop((left, top, right, bottom))

        # TODO mss.tools - отвечает за сохранение  mss.tools.to_png()
        cropped.save(f'screen/{time.time()}-{x}-{y}.png')


window = MouseWindow()
with mouse.Listener(on_click=window.on_click) as listener:
    listener.join()
