from abc import ABC, abstractmethod


class QueueWriter(ABC):

    @abstractmethod
    def put_message(self, item):
        raise
