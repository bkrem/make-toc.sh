# make-toc.sh
<a href="https://github.com/tobiasbueschel/awesome-pokemon/pulls"><img alt="Pull Requests Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square"></a>

A Shell script to automatically generate a Table of Contents from Markdown files.

## Dependencies
`sed` (`gnu-sed`) - make-toc depends on the GNU version of `sed`

### Linux
You should be all good to go :+1:

### OSX
#### Homebrew
To install `gnu-sed` as `sed` in your PATH:
```sh
brew install gnu-sed --with-default-names
```
To install as `gsed` alongside OSX's default BSD `sed`, simply omit the `--with-default-names` flag.

_Note:_ In this case it is recommended you set the following alias for your terminal session or as a permanent fix in your `.bashrc`/`.zshrc` file:
```
alias sed='gsed'
```
The script expects the GNU version on the `sed` command, and **will fail if used with the BSD version**. (I'm working on removing this dependency all together).

#### MacPorts
```sh
sudo port install gsed # see Note above
```


## Usage
```
. ./make-toc.sh ...opts <source-file.md> <output-file.md>
```

- `<source-file.md>` - The markdown file a ToC should be generated for.
- `<output-file.md>` - A filename to label the script's output, e.g. `toc.md`.

### ...opts
- `-s n`/`--skip n` - Skip `n` headers from the top of the file. For example, to omit the file's title header use `. ./make-toc.sh -s 1 ...`.
