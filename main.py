import threading, queue, threaded_queue_reader


def start_simulation():
    print("start simulation")
    q = queue.Queue()

    reader1 = threaded_queue_reader.Reader(q, "reader1")
    reader2 = threaded_queue_reader.Reader(q, "reader2")

    threading.Thread(target=reader1.read_queue_messages, daemon=True).start()
    threading.Thread(target=reader2.read_queue_messages, daemon=True).start()

    # send thirty task requests to the worker
    for item in range(30):
        q.put(str(item))
    print('All task requests sent\n', end='')

    # block until all tasks are done
    q.join()
    print('All work completed')


if __name__ == '__main__':
    start_simulation()
