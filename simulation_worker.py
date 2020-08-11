import random
import time


class SimulationWorker:
    @staticmethod
    def start_simulation(simulation_parameters):
        print("running simulation: " + simulation_parameters)

        time.sleep(random.randint(0, 1));

        print("simulation completed")