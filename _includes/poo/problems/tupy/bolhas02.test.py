import unittest
from unittest.mock import patch

try:
    import sys; sys.path.append('_private/poo/problems/tupy') 
    from bolhas02 import Bolha, Crianca, keyboard
except:
    pass

class TestBolha(unittest.TestCase):
    def test_bolha_init(self):
        bolha = Bolha(10, 20, 5)
        self.assertEqual(bolha.x, 10)
        self.assertEqual(bolha.y, 20)
        self.assertEqual(bolha.velocidade, 5)

    # A bolha se move para cima, de acordo com sua velocidade; ou seja, a cada chamada a `update()`, sua posição `y` deve ser alterada para `y - velocidade`.
    def test_bolha_se_move_para_cima(self):
        bolha = Bolha(10, 20, 5)
        bolha.update()
        self.assertEqual(bolha.y, 15)
        bolha.update()
        self.assertEqual(bolha.y, 10)

        bolha = Bolha(10, 20, 3)
        bolha.update()
        self.assertEqual(bolha.y, 17)

    # Quando a bolha sai da tela (`y < -20`), ela reaparece na parte inferior da tela (`y = 520`).
    def test_bolha_reaparece(self):
        bolha = Bolha(10, -11, 10)
        bolha.update()
        assert bolha.y == 520

    def test_bolha_reaparece_acima(self):
        bolha = Bolha(10, 520, -1)
        bolha.update()
        self.assertEqual(bolha.y, -20)

class TestCrianca(unittest.TestCase):
    def test_init(self):
        # Test that the child's position is set correctly
        c = Crianca(100, 200)
        self.assertEqual(c.x, 100)
        self.assertEqual(c.y, 200)

    def test_update(self):
        # Test that the child moves left when the left arrow key is pressed
        c = Crianca(100, 200)
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'Left'):
            c.update()
        
        # c.update({'Left': True})
        self.assertEqual(c.x, 80)

        # Test that the child moves right when the right arrow key is pressed
        c = Crianca(100, 200)
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'Right'):
            c.update()
        self.assertEqual(c.x, 120)

        # Test that the child moves up when the up arrow key is pressed
        c = Crianca(100, 200)
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'Up'):
            c.update()
        self.assertEqual(c.y, 180)

        # Test that the child moves down when the down arrow key is pressed
        c = Crianca(100, 200)
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'Down'):
            c.update()
        self.assertEqual(c.y, 220)

if __name__ == '__main__':
    import sys
    unittest.main(exit=False)
