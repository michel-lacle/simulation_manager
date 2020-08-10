from simulation_worker import SimulationWorker
from queue_reader import QueueReader
from queue_writer import QueueWriter
from queue import Queue


class InProcessReaderWriter(QueueReader, QueueWriter):
    queue = Queue();

    def __init__(self, name):
        self.name = name

    def read_queue_messages(self):
        print("read queue messages: " + self.name)

        while True:
            item = InProcessReaderWriter.queue.get()
            print(self.name + f': working on {item}')

            SimulationWorker.start_simulation(item)

            print(self.name + f': finished {item}')
            InProcessReaderWriter.queue.task_done()

    def put_message(self, item):
        InProcessReaderWriter.queue.put(item);
