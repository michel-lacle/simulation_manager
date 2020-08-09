import simulation_worker


class Reader:

    def __init__(self, queue, name):
        self.queue = queue
        self.name = name

    def read_queue_messages(self):
        print("read queue messages: " + self.name)

        while True:
            item = self.queue.get()
            print(self.name + f': working on {item}')

            simulation_worker.SimulationWorker.start_simulation(item)

            print(self.name + f': finished {item}')
            self.queue.task_done()
