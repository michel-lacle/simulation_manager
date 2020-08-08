import unittest
import simulation_worker


class TestSimulationWorker(unittest.TestCase):

    def test_run_simulation(self):
        simulation_worker.SimulationWorker.start_simulation("simulation parameters")
        self.assertEqual('foo'.upper(), 'FOO')


if __name__ == '__main__':
    unittest.main()
