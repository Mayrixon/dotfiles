# Settings for Notes

## File type

There are several main kind file types for notes, among which I know are
`*.md`, `*.wiki`, `*.org` and `*.norg`. After the comparison, I chose `*.md` as
the file type for all notes. The reasons are following:
- Plain text based file type. Plain text files can be read and edited by all
  text editors, which means general edit-ability. All of these four types are
  all pure text based file types.
- A smooth learning curve. `*.wiki` requiring `vimwiki`, `*.org` requiring
  `org-mode` on `emacs` or `orgmode.vim` on `vim`, `*.norg` requiring `neorg`
  on `neovim`. However, `*.md` can be edited and rendered properly on a lot of
  text editors.
- Extendability. Both `vimwiki` and `org-mode` have more functions supported
  than vanilla markdown files, but because of the steady learning curve and the
  lack of support from other software, they are not chosen. On the other side,
  markdown files can also work in other double-link note applications, such as
  logseq and Obsidian.

## Applications

Here is only a beginning plan to start noting. The following applications are
planned to use:
- Vim/Neovim with LSP server zk. Vim is a fast text editor for experience
  users. With the help of LSP server zk, it's possible to jump to wiki links.
- Logseq or Obsidian. After a set of simple test, these two applications can
  works together, and hence the first vault/database would be built and test
  them further. After a longer period of use, a more detailed use scenario plan
  will be proposed.

## Other applications may be useful

- zk
- neuron
