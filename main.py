import threading, queue, inprocess_queue_reader_writer
from inprocess_queue_reader_writer import InProcessReaderWriter


def start_simulation():
    print("start simulation")

    reader1 = InProcessReaderWriter("reader1")
    reader2 = InProcessReaderWriter("reader2")

    threading.Thread(target=reader1.read_queue_messages, daemon=True).start()
    threading.Thread(target=reader2.read_queue_messages, daemon=True).start()

    # send thirty task requests to the worker
    for item in range(30):
        reader1.put_message(str(item))
    print('All task requests sent\n', end='')

    # block until all tasks are done
    InProcessReaderWriter.queue.join()
    print('All work completed')


if __name__ == '__main__':
    start_simulation()
