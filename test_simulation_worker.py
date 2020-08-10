import unittest
import simulation_worker
import simulation_manager_main


class TestSimulationWorker(unittest.TestCase):

    def test_run_simulation(self):
        simulation_worker.SimulationWorker.start_simulation("simulation parameters")
        self.assertEqual('foo'.upper(), 'FOO')

    def test_run_main(self):
        simulation_manager_main.start_simulation()


if __name__ == '__main__':
    unittest.main()
