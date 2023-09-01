class BaseTupyObject:
  def _hide(self): pass
  def _show(self): pass
  def _collides_with(self, obj): return False
  def _destroy(self): pass
  def destroy(self): pass

class BaseImage(BaseTupyObject):
  pass

class Image(BaseImage):
  def __new__(cls, *args, **kwargs):
    self = super().__new__(cls)
    self.x = 0
    self.y = 0
    self.file = self.__class__.__name__.lower() + '.png'
    self.angle = 0
    return self

def run(x):
  pass

class KeyboardStub:
  def is_key_just_down(self, key): return False
  def is_key_down(self, key): return False
  def is_key_up(self, key): return True

keyboard = KeyboardStub()

class MouseStub:
  def __init__(self):
    self.x = 0
    self.y = 0
  def is_button_just_down(self): return False
  def is_button_down(self): return False

mouse = MouseStub()