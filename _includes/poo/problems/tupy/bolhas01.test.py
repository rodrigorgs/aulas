import unittest

try:
    import sys; sys.path.append('_private/poo/problems/tupy')
    from bolhas01 import Bolha
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

if __name__ == '__main__':
    import sys
    unittest.main(exit=False)
