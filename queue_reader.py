from abc import ABC, abstractmethod


class QueueReader(ABC):

    @abstractmethod
    def read_queue_messages(self):
        raise
