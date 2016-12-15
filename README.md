# make-toc.sh
[![npm version](https://badge.fury.io/js/make-toc.svg)](https://badge.fury.io/js/make-toc)
<a href="https://github.com/bkrem/make-toc.sh/pulls"><img alt="Pull Requests Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square"></a>

A Shell script to automatically generate a Table of Contents from Markdown files.


## Contents
- [Installation](#installation)
    - [NPM](#npm)
    - [Manually](#manually)
- [Usage](#usage)
    - [NPM](#npm-1)
    - [Manually](#manually-1)
- [Documentation](#documentation)
    - [...opts](#opts)


## Installation
### NPM
```
npm install -g make-toc
```

### Manually
1. Clone the repo or download as a ZIP and extract it.
2. Add the markdown file you want to generate a ToC for to the project's folder.


## Usage
### NPM
```
make-toc ...opts source-file.md output-file.md
```

### Manually
```
. ./make-toc.sh ...opts source-file.md output-file.md
```


## Documentation
- `source-file.md` - The markdown file a ToC should be generated for.
- `output-file.md` - A filename to label the script's output, e.g. `toc.md`.

### ...opts
This section outlines flags for the script which may be used individually or in combination.

#### `-s <n>` or `--skip <n>`
Skips `n` headers from the top of the file.

For example, to omit the file's title header use:
```
make-toc -s 1 source.md target.md
```

<br/>

#### `-d <n>` or `--depth <n>`
Sets the maximum depth for the table.

For example, to generate a fairly shallow table of the top-level and second-level headers only, use:
```
make-toc -d 2 source.md target.md
```
Passing `-d 0` to the script will result in default behaviour, i.e. full depth.
