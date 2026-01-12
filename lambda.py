import os
import boto3
import logging

# configure logging
logging.getLogger().setLevel(logging.INFO)

# init globals
BUCKET = ""
if "BUCKET" in os.environ:
    ENV_TAG = os.environ["BUCKET"]

# init boto3 clients
LDA = boto3.client("lambda")


def handler(event, context):
    logging.info(event)

    # the end
    logging.info("This is the end")
    return None
