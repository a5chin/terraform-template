from __future__ import annotations

import unittest
import sys
from pathlib import Path

import pytest


current_dir = Path(__file__).resolve().parent
sys.path.append((current_dir / "../").as_posix())

from extract import get_tablename


class PathTestCase(unittest.TestCase):
    def setUp(self: PathTestCase) -> None:
        self.valid_paths = [
            "rankings/2024/01-01/spanner-export.json",
            "contents/2025/04-01/spanner-export.json",
        ]
        self.invalid_paths = [
            "2024/01-01/spanner-export.json",
            "contents/04-10/spanner-export.json",
        ]
        self.bucket = "sample"

    def test_valid_path(self: PathTestCase) -> None:
        for p in self.valid_paths:
            table, path = get_tablename(self.bucket, p)
            self.assertIsInstance(table, str)
            self.assertIsInstance(path, str)

    def test_invalid_path(self: PathTestCase) -> None:
        for p in self.invalid_paths:
            with pytest.raises(ValueError):
                _, _ = get_tablename(self.bucket, p)
