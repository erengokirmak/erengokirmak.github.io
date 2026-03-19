+++
date = '2026-02-27T14:49:04+03:00'
draft = false 
title = "uv: python management"
description = "Ramblings about my new love for Python project management"
tags = ["programming"]
showToc = false

[cover]
image = ""
alt = "Descriptive alt text"
caption = "Optional caption text"
relative = false
hidden = false
+++
I use Python a lot. In the (hopefully) final semester of my Bachelor's, almost all my courses involve using Python at some point or another. I'm doing my senior project mainly in Python, I have an ML course where most assignments require[^1] Python, I'm doing research with LLMs so that also devolves into[^1] Python. In all this mess, I'm dealing with Python and Python packages. First, I will tell you the way I started to deal with these, and then I will introduce my current method.

## My old solution
I started with the path of least resistance: Create a `requirements.txt` file in the project and create a virtual environment using `python -m venv .venv`. When a package is needed, just `pip install` that package! This is very much fine...for the first commit of the project. Starting from there, the `reqiurements.txt` file becomes increasingly brittle. Any time you say to yourself:

> Ah, I should add this package to make my life easier!

And introduce another dependency, you *must* not forget to update the requirements file accordingly (with the correct version of the package). If you forget it, the workaround is actually rather simple:

```zsh
pip freeze | grep the-package-you-added
```

H~~2~~o

Followed by adding this to the `requirements.txt`. Is this okay? Sure. However, you again relied on your own vigilance to catch that you forgot to add a dependency. This problem goes on for a while. Additionally, when creating a virtual environment, you are bound to the Python versions you have installed in your device. If you want to have a Python 3.11 environment but have Python 3.14 installed, you will have to do some workarounds. Recently, and finally, this was my breaking point. I knew from a previous course that `uv` existed. I just had not tried to use it outside that course's context. So, I dived in:

## `uv`
[uv](https://docs.astral.sh/uv/) is a package and **project** manager for Python. The important word there is "project." After trying it out, I realized more clearly what I was missing with the `venv+pip` method: I didn't have a project manager at all, *I* was the project manager. Sure, there was a list of what was needed for the project to run, but that was a manual and brittle process. In contrast, `uv` does things in a more programmatic way. Let's say you want to create a Python project that uses Python 3.11.x. You use:

```sh
uv init --python=3.11 new_project
```

This creates a new project in the `new_project` directory, where the project structure looks like so:

```tree
new_project
├── .gitignore
├── main.py
├── pyproject.toml
├── .python-version
└── README.md
```

There are multiple nice things about this process:
- You are independent of the Python version you have on your device, and the Python version is explicitly saved in the `.python-version` file for future reference.
- You have a `pyproject.toml` file that explicitly keeps track of the dependencies the user *wanted* in contrast to the old method where `pip freeze` would return all packages installed.
- `.gitignore` and `main.py` are quality of life additions which mean that you automatically get a gitignore for common files and an entry point for your application. 


This is a massive improvement to doing `python -m venv .venv` because you are independent from the Python version you have installed in your computer. In fact, this was the reason I tried uv: without changing the Python version on my PC, I couldn't find an easy way to specify the Python version I wanted.

Anyway, after this point you can start adding packages. Let's start with these few:

```sh
uv add numpy pandas spacy
```

If we check the `pyproject.toml`[^2] file at this point, I think you'll understand why I find this to be much better:

```toml
[project]
name = "sample-project"
version = "0.1.0"
description = "Sample description"
readme = "README.md"
requires-python = ">=3.14"
dependencies = [
    "numpy>=2.4.2",
    "pandas>=3.0.1",
    "spacy>=3.8.11",
]
```

As opposed to a `pip freeze`, you don't get *all* the packages. You only get the ones you *needed*. Plus, you didn't need to do two iterations: In the old solution, you would have to install *and* modify the `requirements.txt`. Here, they are in one command.

### Some small notes
*Apparently* `uv` does not install `pip` automatically. In hindsight, this is not too weird, as pip is indeed just another package. However, some packages implicitly assume `pip` to be present. For example, if you try to download "en_core_web_sm" using the `spacy` package:

```sh
uv run spacy download en_core_web_sm
.venv/bin/python3: No module named pip
```

This took me a rather embarassing amount of time to fix. Regardless, the fix is easy: `uv add pip`. Simple! Furthermore, you can still use the pip interface by `uv pip install ...`. This is useful if you had a project already and are trying to migrate to a uv-managed project.

### Running you project
Running a uv-managed project can be done in two ways:
1. Activating the virtual environment uv creates, and `python main.py`,
2. Using `uv run main.py`

The second option uses the same Python instance as the first option. The difference is that it does not require you to activate the virtual environment. This is another win in my book, as using `uv run` is less brittle as it is self-contained.

## Conclusion
I found the design philosophy and usage of `uv` to be very intuitive and helpful. I'm planning to use it on my personal projects for now to get a better feel for it. If my opinion stands the test of time, you can expect to see a `uv.lock` file in works I publish :P


[^1]: Of course, I could do these in Not-Python™ but that is a separate pain too.
[^2]: The file contains information that I don't touch on such as the `readme` field. Those are also interesting, but not the main point I want to push.