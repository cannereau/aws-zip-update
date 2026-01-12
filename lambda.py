import os
import re
import boto3
import logging

# configure logging
logging.getLogger().setLevel(logging.INFO)

# init globals
BUCKET = ""
if "BUCKET" in os.environ:
    BUCKET = os.environ["BUCKET"]

# init boto3 clients
LDA = boto3.client("lambda")


def handler(event, context):
    logging.info(f"ENV_BUCKET:{BUCKET}")

    # check event
    if (
        "detail" in event
        and "bucket" in event["detail"]
        and "name" in event["detail"]["bucket"]
        and "object" in event["detail"]
        and "key" in event["detail"]["object"]
        and "version-id" in event["detail"]["object"]
    ):
        # check bucket
        logging.info(f"EVT_BUCKET:{event['detail']['bucket']['name']}")
        if BUCKET == event["detail"]["bucket"]["name"]:
            # retrieve lambda function name
            match = re.search(r"^(.*)\.[^\.]+$", event["detail"]["object"]["key"])

            # check object
            if match is not None:
                # update lambda function code
                LDA.update_function_code(
                    FunctionName=match.group(1),
                    S3Bucket=BUCKET,
                    S3Key=event["detail"]["object"]["key"],
                    S3ObjectVersion=event["detail"]["object"]["version-id"],
                )

            else:
                logging.warning(f"Invalid Object:{event['detail']['object']['key']}")

        else:
            logging.warning("Invalid Bucket")

    else:
        logging.warning("Invalid Event")

    # the end
    logging.info("This is the end")
    return None
