#!/bin/bash
# Script that runs tests & produces coverage reports and build artifacts.
# Returns non-zero exit code if any of the tests fail.

./scripts/clean.sh
poetry run pytest --cov-report term-missing --cov-report html --cov=src --durations=0 --durations-min=5.0 --tb=auto
