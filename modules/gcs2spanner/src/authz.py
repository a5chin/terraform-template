import google.auth
import google.auth.transport.requests


def get_token() -> str:
    """Get an access token from Google API.

    This function gets the access token using default Google credentials and authenticates
    the request using the `google.auth.transport.requests` library.

    Returns
    -------
        str: The access token string.

    """
    credentials, _ = google.auth.default(
        scopes=["https://www.googleapis.com/auth/cloud-platform"]
    )
    auth_req = google.auth.transport.requests.Request()
    credentials.refresh(auth_req)

    return credentials.token
