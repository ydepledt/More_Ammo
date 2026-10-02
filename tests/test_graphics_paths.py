"""Check bundled prototype icons without requiring a Factorio installation.

Run from the repository root with: python -m unittest discover -s tests
"""

from pathlib import Path
import re
import unittest


ROOT = Path(__file__).resolve().parents[1]
PREFIX = "__More_Ammo__/"


class GraphicsPathTests(unittest.TestCase):
    def test_local_icon_paths_match_bundled_files_exactly(self):
        constants = dict(re.findall(
            r'^(\w+)\s*=\s*"(__More_Ammo__/[^\"]+)"',
            (ROOT / "data.lua").read_text(encoding="utf-8"),
            re.MULTILINE,
        ))
        files = {path.relative_to(ROOT).as_posix() for path in (ROOT / "graphics").rglob("*") if path.is_file()}
        checked = 0
        for source in (ROOT / "prototypes").rglob("*.lua"):
            text = source.read_text(encoding="utf-8")
            for match in re.finditer(r'\bicon\s*=\s*(?:(\w+)\s*\.\.\s*)?"([^\"]+)"', text):
                constant, value = match.groups()
                if constant:
                    self.assertIn(constant, constants, str(source))
                    value = constants[constant] + value
                if not value.startswith(PREFIX):
                    continue
                checked += 1
                with self.subTest(source=source.relative_to(ROOT).as_posix(), icon=value):
                    self.assertIn(value.removeprefix(PREFIX), files)
        self.assertGreater(checked, 0, "No bundled icon references were checked")


if __name__ == "__main__":
    unittest.main()
