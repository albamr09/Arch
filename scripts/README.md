# Scritps

Scripts to create common and diff files for dotfiles:

- `create_common`: extracts lines that are common between files. If lines are different these are replaced by `\n`.
- `create_different`: extracts lines that are different between files. If lines are common these are replaced by `\n`.
- `diff_files`: shows the resulting diff of a dotfile for all the themes.