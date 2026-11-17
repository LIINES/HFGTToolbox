:: Installs git pre-commit hooks, runs tests & coverage report
call scripts\clean.cmd
poetry run pytest --cov-report term-missing --cov-report html --cov=src --durations=0 --durations-min=5.0 --tb=auto
