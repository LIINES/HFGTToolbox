"""Helper functions for the tests."""
import os
import functools
import pytest 

from hfgt_toolbox.HFGTToolbox import debugEquivObjs, dictify

def julia_test():
    """
    Decorator to fail a Julia test if RUN_JULIA_TESTS is False.
    """
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            if os.getenv("FAIL_JULIA_TESTS", "False").lower() == "true":
                # Use result.stderr (a string) to avoid the TypeError you saw
                pytest.fail(reason=f"Automatically failed because FAIL_JULIA_TESTS = True.")
            return func(*args, **kwargs)
        return wrapper
    return decorator


def _remove_keys_recursively(data):
    """
    Recursively removes specific keys from a dictionary or list of dictionaries.
    Written by Google Gemini.
    """
    keys_to_remove = [
        "inputFilePath", "runCode", "outputFileName", "outputDirectory",
        "juliaOutputFilePath", "outputFilePath", "outputFileType"
    ]
    if isinstance(data, dict):
        return {
            k: _remove_keys_recursively(v)
            for k, v in data.items()
            if k not in keys_to_remove
        }
    elif isinstance(data, list):
        return [_remove_keys_recursively(item) for item in data]
    else:
        return data

def compare_objects(obj_1, obj_2):
    """Compare two objects and return whether they are equivalent,
    and an error message (if they are not equivalent).
    This is a simple wrapper around debugEquivObjs() which first
    removes any keys which are not important to assessing the
    correctness of the tests.
    dictify() is called first so that the keys can be removed.

    Args:
        obj_1 (Object): First object.
        obj_2 (Object): Second object.

    Returns:
        bool, str: Whether the two objects are equivalent, and an
            error message if they are not.
    """    

    obj_1 = _remove_keys_recursively(dictify(obj_1, "debug"))
    obj_2 = _remove_keys_recursively(dictify(obj_2, "debug"))

    result, err_message = debugEquivObjs(obj_1, obj_2)
    return result, err_message
