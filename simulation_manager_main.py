import threading
from inprocess_queue_reader_writer import InProcessReaderWriter
from aws_sqs_reader import AwsQueueReader


def start_simulation():
    print("start simulation")

    reader_writer1 = InProcessReaderWriter("reader1")
    reader_writer2 = InProcessReaderWriter("reader2")

    threading.Thread(target=reader_writer1.read_queue_messages, daemon=True).start()
    threading.Thread(target=reader_writer2.read_queue_messages, daemon=True).start()

    # send thirty task requests to the workers
    for item in range(30):
        reader_writer1.put_message(str(item))
    print('All task requests sent\n', end='')

    # block until all tasks are done
    InProcessReaderWriter.queue.join()
    print('All work completed')


def start_aws_queue_reader():

    aws_reader = AwsQueueReader()

    aws_reader.read_queue_messages()


if __name__ == '__main__':
    #start_simulation()

    start_aws_queue_reader()
