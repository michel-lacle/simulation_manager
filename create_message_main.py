import boto3, os
from random import random

os.environ["AWS_PROFILE"] = "terraform-pr-private"

sqs = boto3.resource('sqs', region_name="us-east-1")

# Get the queue
queue = sqs.get_queue_by_name(QueueName='simulation_manager.fifo')

for x in range(10):
    print(x)

    simulation_id = str(x)
    # Create a new message
    response = queue.send_message(MessageBody='simulation_request: ' + simulation_id, MessageGroupId=simulation_id,
                                  MessageDeduplicationId=simulation_id + str(random()))

    # The response is NOT a resource, but gives you a message ID and MD5
    print(response.get('MessageId'))
    print(response.get('MD5OfMessageBody'))
