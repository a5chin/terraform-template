import os
from logging import Logger
from pathlib import Path

import functions_framework
import requests
from cloudevents.http.event import CloudEvent

from authz import get_token
from extract import get_tablename
from logger import get_logger


@functions_framework.cloud_event
def create(cloud_event: CloudEvent) -> None:
    """Create Dataflow functions.

    Args:
        cloud_event (CloudEvent): Event info.

    """
    logger: Logger = get_logger()

    data: dict = cloud_event.data
    (
        name,
        bucket,
        content_type,
    ) = (
        data.get("name"),
        data.get("bucket"),
        data.get("contentType"),
    )

    if not (name and bucket and content_type):
        logger.error(f"Cannot read received data: {name=}, {bucket=}, {content_type=}")
        return

    if content_type != "application/json":
        logger.info("Skip dataflow because the file name is %s.", name)
        return

    table = get_tablename(bucket, name)

    access_token: str = get_token()

    api = f"https://dataflow.googleapis.com/v1b3/projects/{os.environ['PROJECT_ID']}/locations/{os.environ['REGION']}/templates"
    headers = {"Authorization": f"Bearer {access_token}"}
    body = {
        "jobName": f"{os.environ['JOB_NAME']}-{table}",
        "gcsPath": os.environ["GCS_PATH"],
        "parameters": {
            "instanceId": os.environ["INSTANCE_ID"],
            "databaseId": os.environ["DATABACE_ID"],
            "inputDir": f"{os.environ['INPUT_DIR']}/{Path(name).parent}",
        },
        "environment": {
            "serviceAccountEmail": os.environ["SERVICE_ACCOUNT_EMAIL"],
            "tempLocation": os.environ["TEMP_LOCATION"],
            "subnetwork": os.environ["SUBNETWORK"],
            "workerRegion": os.environ["REGION"],
        },
    }
    response = requests.post(api, json=body, headers=headers, timeout=3)
    logger.info("Dataflow creation requested by %s", body)

    assert response.status_code == requests.codes.ok
