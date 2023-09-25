import unittest
from unittest.mock import patch, MagicMock

try:
    import sys; sys.path.append('_private/poo/problems/tupy')
    from bolhas03 import Bolha, Crianca, Pedra, keyboard, BaseTupyObject, bolhas
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
    
    def test_crianca_tem_pedra(self):
        c = Crianca(100, 200)
        self.assertTrue(hasattr(c, 'pedra'))
        self.assertTrue(isinstance(c.pedra, Pedra) or c.pedra is None)
        self.assertIsInstance(c.pedra, Pedra)

    def test_espaco_lanca_pedra(self):
        c = Crianca(100, 200)
        c.lancar = MagicMock()
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'space'):
            c.update()
        c.lancar.assert_called_once()

    def test_pedra_move_ao_lancar(self):
        c = Crianca(100, 200)
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'space'):
            c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        self.assertEqual(c.pedra.x, 160)
        self.assertEqual(c.pedra.y, 200)

    def test_pedra_nao_lanca_duas_vezes_seguidas(self):
        c = Crianca(100, 200)
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'space'):
            c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'space'):
            c.update(); c.pedra.update()
        self.assertEqual(c.pedra.x, 200)
        self.assertEqual(c.pedra.y, 200)

    def test_pedra_pode_ser_relancada_ao_sair_da_tela(self):
        c = Crianca(750, 200)
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'space'):
            c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'space'):
            c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        # print(c.pedra.x)
        self.assertTrue(c.pedra.x == 770 or c.pedra.x == 790)
        self.assertEqual(c.pedra.y, 200)

    def test_pedra_move_com_crianca(self):
        c = Crianca(100, 200)
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'Right'):
            c.update(); c.pedra.update()
            c.update(); c.pedra.update()
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'Up'):
            c.update(); c.pedra.update()
            c.update(); c.pedra.update()
        # ^ Equivalent to:
        # c.x = 140; c.y = 160
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'space'):
            c.update(); c.pedra.update()
            c.update(); c.pedra.update()
        # print(c.pedra.x, c.pedra.y)
        self.assertTrue(c.pedra.x == 180 or c.pedra.x == 200)
        self.assertTrue(c.pedra.y == 160)
        # self.assertEqual(c.pedra.x, 140)
        # self.assertEqual(c.pedra.y, 180)

    def test_colide_com_bolha(self):
        bolhas.clear()
        b1 = Bolha(160, 200, 5)
        b2 = Bolha(160, 500, 5)
        bolhas.append(b1)
        bolhas.append(b2)
        c = Crianca(100, 200)
        with patch('__main__.keyboard.is_key_just_down', side_effect=lambda x: x == 'space'):
            c.update(); c.pedra.update()
        with patch('__main__.BaseTupyObject._collides_with', \
                   side_effect=lambda obj: obj == b1):
            with patch.object(b1, '_collides_with', \
                   side_effect=lambda obj: obj == c.pedra):
                c.update(); c.pedra.update()
        c.update(); c.pedra.update()
        self.assertEqual(len(bolhas), 1)
        self.assertEqual(bolhas[0], b2)

if __name__ == '__main__':
    import sys
    unittest.main(exit=False)


