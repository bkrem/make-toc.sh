# make-toc.sh
A Shell script to automatically generate a Table of Contents from Markdown files.

## Dependencies


## Usage
```
. ./make-toc.sh [...opts] <source-file.md> <output-file.md>
```

- `<source-file.md>` - The markdown file a ToC should be generated for.
- `<output-file.md>` - A filename to label the script's output, e.g. `toc.md`.

### [...opts]
- `-s n`/`--skip n` - Skip `n` amount of headers from the top of the file. For example, to omit the file's title header use `-s 1`
