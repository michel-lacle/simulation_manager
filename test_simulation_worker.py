import unittest
import simulation_worker
import main


class TestSimulationWorker(unittest.TestCase):

    def test_run_simulation(self):
        simulation_worker.SimulationWorker.start_simulation("simulation parameters")
        self.assertEqual('foo'.upper(), 'FOO')

    def test_run_main(self):
        main.start_simulation()


if __name__ == '__main__':
    unittest.main()
