# [Sphinx documentation generation](http://www.sphinx-doc.org/en/master/)

## Getting Started (if you just want to build the documentation locally):
- `git clone` this repository
- Install the required tools using `pip install -r requirements.txt` in this directory.
- Follow the build instructions below

## Getting Started (If you want to modify this documentation):
- Create a fork of the this repository
- `git clone` the forked repository
- Install the required tools using `pip install -r requirements.txt` in this directory.
- Make your changes and rebuild using the build instructions below.
- Push your changes to your fork of this repository
- Raise a pull request to https://github.com/casper-astro/mlib_devel

## Information:
- A [ReadtheDocs](https://readthedocs.org/) Sphinx theme `sphinx-rtd-theme` is used in order to host our documents on their platform.
- ReadtheDocs uses a webhook with the GitHub repository to detect documentation changes and re-build accordingly.
- Sphinx by default uses reStructuredText as its markup language, however Markdown (CommonMark spec) is supported via the `recommonmark` python package.
- Markdown tends to be a less-tedious markup language than reStructured Text, but the latter has native Sphinx support.
- `conf.py` is the configuration file for the Sphinx documentation builder.
- `index.rst` is the 'master document' unless otherwise specificed using the `master_doc` variable in `conf.py`
- Any static documents referred to within the documentation shall be stored in the `_static/` directory.

## Building:
1. Open a terminal and `cd` into the `docs/` directory of your cloned repository
2. Build using `make html` command, which will build the documentation in the `_build/` directory.
3. Pay close attention to any warning that might appear.
4. Open a web browser and point it towards the build directory, then manually inspect the built html, starting at `_build/index.html`.

**Note: Please do not push a build directory to GitHub.**

## Resources:
- [ReadtheDocs](https://readthedocs.org/)
- [ReadtheDocs Sphinx theme](https://github.com/rtfd/sphinx_rtd_theme)
- [Markdown Sphinx support](https://github.com/rtfd/recommonmark)
- [Markdown Sphinx configuration](http://www.sphinx-doc.org/en/master/usage/markdown.html)

## Definitions:
- **ReadtheDocs**: an open-source software documentation hosting platform.
- **Sphinx**: documentation generator that can output formats such as: HTML, LaTeX, ePub's, etc.
- **reStructuredText**: easy-to-read, what-you-see-is-what-you-get plaintext markup syntax and parser system. It is useful for in-line program documentation (such as Python docstrings), for quickly creating simple web pages, and for standalone documents. reStructuredText is designed for extensibility for specific application domains.
- **Markdown**: a lightweight markup language with plain text formatting syntax. It is designecd so that it can be converted to HTML and many other formats.
