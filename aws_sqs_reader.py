from queue_reader import QueueReader
import boto3
import os
from simulation_worker import SimulationWorker


class AwsQueueReader(QueueReader):

    def read_queue_messages(self):

        if os.environ["ENVIRONMENT"] == "dev":
            print("using iam role of ec2 instance")
        else:
            os.environ["AWS_PROFILE"] = "terraform-pr-private"

        sqs = boto3.resource('sqs', region_name="us-east-1")

        queue = sqs.get_queue_by_name(QueueName='simulation_manager.fifo')

        while True:
            for message in queue.receive_messages(MaxNumberOfMessages=1):

                print('Incomming Message, {0}!'.format(message.body))
                SimulationWorker.start_simulation(message.body)

                message.delete()
