from pynput import mouse
import mss
import mss.tools
import time

class MouseWindow:
    def __init__(self):
        self.crop_size = 200
        self.sct = mss.mss()

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
        
        filename = f'screen/{time.time()}-{x}-{y}.png'
        mss.tools.to_png(screenshot.rgb, screenshot.size, output=filename)

window = MouseWindow()
with mouse.Listener(on_click=window.on_click) as listener:
    listener.join()