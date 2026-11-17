# README

This Readme covers the documentation process for the `src_python` folder of the HFGT Toolbox codebase.

Written by Michael Stewart (CSIRO, Australia).

## Code documentation process

The process I am following to document the codebase is as follows:

 1. Switch to the `feature/documentation` branch via `git`.
 2. Write docstrings, add type hinting, and/or comments on individual functions/classes in the Python code.
 3. Generate the automated HTML documentation via Sphinx.
 4. Commit and push my changes to the `feature/documentation` branch.
 5. Submit a pull request to merge the branch into the `master` branch, for Amro to review.

## Switching to the `feature/documentation` branch

Before starting to work on the documentation, ensure you are in the `feature/documentation` branch. In a terminal window, type:

   git checkout feature/documentation

You will need to ensure that this branch is in sync with the `master` branch prior to making changes, otherwise you may run into merge conflicts.

You may also elect to create your own branch if that is easier, for example:

   git branch feature/documentation/michael
   git checkout -b feature/documentation/michael

## Writing docstrings, adding type hinting, and/or comments

The next step is to start documentating the code. There are several key elements to consider, outlined below.

### Type hinting

Below is a description of what Type Hinting is, from Google Gemini:

 > In Python, type hinting is a way to explicitly declare the expected data types of variables, function parameters, and return values. It does not change how Python runs your code (Python is still dynamically typed), but it helps:
 > - Improve code readability.
 > - Catch type-related bugs early using tools like mypy or IDEs.
 > - Provide better autocompletion and documentation in editors.

It is as simple as ensuring that the function has type(s) on its arguments and on what it returns. An example of type hinting is as follows:

    def boolify(myString: str) -> bool:

Here we are saying that `myString` is a `str` and that this function returns a `bool`.

The `typing` library provides several useful type hint classes, for example `List[str]`, `Dict`, and so on. I strongly recommend looking into this library if you haven't already as it makes for much more expressive type hints. The example I have added above does not use the `typing` library at all, but here is an example of a function that does:

    def makeList(s: str) -> List[str]:

The above states that the `s` parameter is a `str`, and the function returns a list of strings. The latter is facilitated by the `typing` library, which provides the `List` class.

### Docstrings

Below is a description of what Docstrings are, once again from Google Gemini:

 > Docstrings in Python are a convenient way to document modules, classes, functions, and methods. They provide a clear description of the purpose and functionality of the code, making it easier for developers and users to understand and maintain.

I follow the PEP-8 standard for docstrings, which look like this:

    def boolify(myString: str) -> bool:
    """Given a string, return that string as a boolean:
     - "true" and "True" will be returned as True
     - "false" and "False" will be returned as False
     - Any other value will raise a ValueError.

    Args:
        myString (str): The string to convert to a boolean.

    Raises:
        ValueError: If the string cannot be converted to a boolean.

    Returns:
        bool: The boolean form of the string.
    """

A breakdown of the above is as follows:
 - At the top is a clear description of the function, and its expected input/output.
 - The second section, `Args`, describes the input(s) in more detail, including their type(s).
 - The third (optional) section describes any errors that the function is expected to raise.
 - The final section describes what the function returns, including its type.

I have a plugin in VSCode which allows me to generate a docstring template by typing `"""` immeditately after a function declaration. I'd recommend looking into similar tools for whichever editor(s) you use, as it saves a lot of time.

### Comments

Many of the functions have inline comments already, but you can add comments as needed. 

However, in my computer science degree I was always taught (and later taught students) that inline comments are best used sparingly. The docstring should adequately describe the function to the point that inline comments are seldom necessary. I would thus recommend focusing on the docstrings before considering whether inline comments are necessary at all.

## Generating the HTML documentation

The next step is to generate the HTML documentation using Sphinx. This documentation lives in [src_python/docs/build](build), and is a series of HTML files which are effectively a website representation of the code documentation. See [build/index.html](build/index.html) for the entire documentation site. 

### Requirements

When installing the below, you can either install it within a virtual environment along with the rest of the requirements of the codebase, or keep it separate (either installing it globally or in a separate virtual environment). I have opted to install Sphinx globally as I am using it for other codebases, but it is up to you.

To install Sphinx, run:

    pip install sphinx

### Generating documentation

To build the Sphinx documentation, navigate to the root directory of this repository and run:

    uv run sphinx-build -b html docs/source docs/build

Note - if you have created any new files/rearranged them, you will need to run the following prior to the above:

    uv run sphinx-apidoc -f -o docs/source src --force --separate

The documentation will be available under [/docs/build](/docs/build).

## Committing your changes to your branch

Once you have documented some code and updated the documentation HTML, you can commit and push your changes to your documentation branch:

    git add .
    git commit -m "added documentation for function x and y"
    git push -u origin feature/documentation/michael

## Submitting a Pull Request for Amro to review

You can repeat the steps above as needed until you are ready to submit them to Amro for review.

Once you are ready to push the changes to the master branch, you can create a pull request. On Bitbucket, go to Branches and select your documentation branch. You should see a popup at the top asking if you want to create a pull request. Click on that, then you will be prompted to write a description of your changes. Once you have written up your changes, you can select Amro as the reviewer, then submit the pull request. Once Amro is happy with your changes they will be merged into the `master` branch.

