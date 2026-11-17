import sys
import pytest
from _pytest.monkeypatch import MonkeyPatch
import pathlib as pl
from loguru import logger
from collections import defaultdict



@pytest.fixture(scope="session")
def monkeypatch_session():
    """Custom session-scoped monkeypatch fixture."""
    m = MonkeyPatch()
    yield m
    m.undo()

@pytest.fixture(scope="session", autouse=True)
def lock_loguru(monkeypatch_session):
    from loguru import logger
    import sys
    
    # Remove the existing loggers, and create a new stderr one 
    # the SUCCESS level (to minimise output during the tests).
    logger.remove()
    logger.add(sys.stderr, level="SUCCESS")
    
    # 2. Lock the methods so the code can't change them during tests
    monkeypatch_session.setattr(logger, "add", lambda *a, **k: 0)
    monkeypatch_session.setattr(logger, "remove", lambda *a, **k: None)

# Argument combinations to check, ordered from most specific to least specific.
# The first match wins, so more-specific combos must come first.
# Adding a new combination is as simple as adding a new row here.
_ARG_COMBOS = [
    ["input_path", "output_directory", "julia_output_directory", "benchmark_path"],
    ["input_path", "output_path", "benchmark_path"],
    ["input_path", "output_directory", "benchmark_path"],
    ["input_path", "output_path"],
    ["input_path_1", "input_path_2"],
]


def _get_output_ext(metafunc, default=".txt"):
    """Read the output file extension from the @pytest.mark.output_ext marker."""
    marker = metafunc.definition.get_closest_marker("output_ext")
    return marker.args[0] if marker else default


def _find_benchmark(bench_dir, prefix):
    """Find the first benchmark file matching the given numeric prefix."""
    if bench_dir.exists():
        matches = list(bench_dir.glob(f"{prefix}_*"))
        if matches:
            return matches[0]
    return None


def _resolve_arg(arg_name, *, input_file, prefix, data_root, metafunc, requested_args):
    """Resolve a single argument value for a given input file."""
    if arg_name == "input_path":
        return input_file

    if arg_name == "output_path":
        ext = _get_output_ext(metafunc)
        out_dir = data_root / "outputs"
        return out_dir / input_file.with_suffix(ext).name

    if arg_name == "benchmark_path":
        return _find_benchmark(data_root / "benchmarks", prefix)

    if arg_name == "output_directory":
        # Use "python" subdirectory when julia_output_directory is also requested
        if "julia_output_directory" in requested_args:
            out_dir = data_root / "outputs" / "python"
        else:
            out_dir = data_root / "outputs"
        rel = out_dir.relative_to(pl.Path.cwd())
        rel.mkdir(exist_ok=True)
        return rel

    if arg_name == "julia_output_directory":
        julia_dir = data_root / "outputs" / "julia"
        rel = julia_dir.relative_to(pl.Path.cwd())
        rel.mkdir(exist_ok=True)
        return rel

    raise ValueError(f"Unknown argument: {arg_name}")


def _format_id_part(arg_name, value):
    """Format a single argument value for use in the test ID."""
    if value is None:
        return "-"
    if arg_name in ("output_directory", "julia_output_directory"):
        return f"outputs/{value.name}"
    return value.name


def _parametrize_file_cases(metafunc, data_root, args):
    """Parametrize test cases that iterate over individual input files."""
    input_dir = data_root / "inputs"
    if not input_dir.exists():
        return

    test_cases = []
    test_ids = []

    for input_file in sorted(input_dir.glob("[0-9]*_*")):
        prefix = input_file.name.split("_")[0]

        values = tuple(
            _resolve_arg(
                arg,
                input_file=input_file,
                prefix=prefix,
                data_root=data_root,
                metafunc=metafunc,
                requested_args=args,
            )
            for arg in args
        )

        id_parts = " / ".join(_format_id_part(a, v) for a, v in zip(args, values))
        test_cases.append(values)
        test_ids.append(f"case_{prefix} ({id_parts})")

    metafunc.parametrize(args, test_cases, ids=test_ids)


def _parametrize_paired_cases(metafunc, data_root):
    """Parametrize test cases that pair two input files sharing the same numeric prefix."""
    input_dir = data_root / "inputs"
    if not input_dir.exists():
        return

    grouped_inputs = defaultdict(list)
    for input_file in sorted(input_dir.glob("[0-9]*_*")):
        prefix = input_file.name.split("_")[0]
        grouped_inputs[prefix].append(input_file)

    test_cases = []
    test_ids = []

    for prefix in sorted(grouped_inputs.keys(), key=int):
        input_pair = grouped_inputs[prefix]
        assert len(input_pair) == 2, (
            f"Expected exactly 2 input files for prefix {prefix}, got {len(input_pair)}"
        )
        test_cases.append(tuple(input_pair))
        file_names = ", ".join(f.name for f in input_pair)
        test_ids.append(f"prefix_{prefix} ({file_names})")

    metafunc.parametrize(["input_path_1", "input_path_2"], test_cases, ids=test_ids)


def pytest_generate_tests(metafunc):
    """
    Parametrize tests based on fixture arguments and files in resources/<test_name>/.

    Supports these argument combinations (checked most-specific first):
      - (input_path, output_directory, julia_output_directory, benchmark_path)
      - (input_path, output_path, benchmark_path)
      - (input_path, output_directory, benchmark_path)
      - (input_path, output_path)
      - (input_path_1, input_path_2)
    """
    test_name = metafunc.function.__name__
    data_root = pl.Path(metafunc.module.__file__).parent / "resources" / test_name

    if not data_root.exists():
        return

    for args in _ARG_COMBOS:
        if all(arg in metafunc.fixturenames for arg in args):
            if args == ["input_path_1", "input_path_2"]:
                _parametrize_paired_cases(metafunc, data_root)
            else:
                _parametrize_file_cases(metafunc, data_root, args)
            return
