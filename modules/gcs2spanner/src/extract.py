from pathlib import Path


def get_tablename(bucket: str, path: str) -> tuple[str]:
    """Extracts the tablename from the given path.

    Args:
        bucket (str): The name of the bucket where the file is stored.
        path (str): The path of the file.

    Raises:
        ValueError: If the directory structure of the path is incorrect.

    Returns:
        str: The tablename extracted from the path.
    """
    dirs: tuple[str] = Path(path).parts

    try:
        table, _, _, _ = dirs
        return table
    except ValueError as err:
        raise ValueError(
            "Incorrect directory."
            "The directory structure should be like "
            f"`{bucket}/table_name/YYYY/MM-DD/file_name` not {path}"
        ) from err
