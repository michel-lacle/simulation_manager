from abc import ABC
from queue_reader import QueueReader
import boto3
import os


class AwsQueueReader(QueueReader):

    def read_queue_messages(self):

        if os.environ["ENVIRONMENT"] == "dev":
            print("using iam role of ec2 instance")
        else:
            os.environ["AWS_PROFILE"] = "terraform-pr-private"

        sqs = boto3.resource('sqs')

        queue = sqs.get_queue_by_name(QueueName='simulation_manager.fifo')

        while True:
            for message in queue.receive_messages(MaxNumberOfMessages=1):

                print('Incomming Message, {0}!'.format(message.body))

                message.delete()