# This plugin is experimental

This plugin is **experimental**. After "playing" with it (if you want), you
should probably uninstall it due to problems it can cause to your workflow.

After creating this plugin and validating the functionality via automated
tests, 2 pretty big problematic areas were discovered:

- it breaks macros if they use `<esc> + char`
- mappings that use `<esc> + char` won't work

So far I don't know how to solve these issues and thus the label "experimental".

Please get in touch (via github issue) if you have an idea how to solve the
above problems.

Update: I opened an [issue](https://github.com/tpope/vim-rsi/issues/13) to Tim
Pope in vim-rsi plugin, since he uses alt mappings there as well. It seems Tim
was unaware of the problem as well.

# Alt mappings in terminal Vim

![Build Status](https://travis-ci.org/bruno-/vim-alt-mappings.png?branch=master)

This plugin enables `Alt` key mappings in **terminal** vim.

Now you can do something like this:

    map <M-a> :echo "You just pressed Alt-a!"<CR>
    map <M-X> :echo "Works with uppercase letters."<CR>
    map <M-5> :echo "Numbers are supported too"<CR>
    map <M-$> :echo "as well as characters..."<CR>
    map <M-?> :echo "and more characters..."<CR>
    map <M-~> :echo "and more..."<CR>

`Alt` behaves as just another modifier key (can't get enough of those, right?)

### Use cases

For example, when having soft-wrapped text in your buffer, to move between
lines you can use `gj` and `gk` ("g" stands for graphical). When you use it
a lot, you may realize that it quickly becomes tedious to have to prepend "g"
every time. Drew Neil in his vimcast ["Soft wrapping text"][soft-wrapping]
suggests mapping the "Command" key (`D`) to graphical keystrokes:

```viml
map <D-j> gj
map <D-k> gk
```

However, in Terminal vim this is not an option, because the "Command" key is
used by the OS, and can't be used for mappings. Furthermore, PC users don't
even *have* a "Command" key. "Alt" mappings to the rescue!

```viml
map <M-j> gj
map <M-k> gk
```

### Installation

Use your favorite plugin manager.

- [Pathogen](https://github.com/tpope/vim-pathogen)
  - just `git clone https://github.com/vim-utils/vim-alt-mappings.git ~/.vim/bundle/vim-alt-mappings`
- [Vundle](https://github.com/gmarik/vundle)
  - add `Bundle 'vim-utils/vim-alt-mappings'` to .vimrc
  - then run `:BundleInstall`
- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  - add `NeoBundle 'vim-utils/vim-alt-mappings'` to .vimrc
  - then run `:NeoBundleInstall`
- [vim-plug](https://github.com/junegunn/vim-plug)
  - add `Plug 'vim-utils/vim-alt-mappings'` to .vimrc
  - then run `:PlugInstall`

### Terminal related setup

- OS X Terminal.app: check "Use option as meta key"<br/>
  ![OS X Terminal.app setting](/osx_terminal.png)

- OS X iTerm2, no setup needed

- other?

### Limitations

Mappings for the following keys are (currently?) not possible:

- `Alt-O` (that's `Alt` big o)<br/>
if this one is set, movements arrow keys produce funny characters in insert and
command line mode.
- `Alt->`, `Alt-[` - couldn't find a way to make these work
- `Alt-space` - when set up, messes up all other mappings

There are more than 90 `Alt` key mappings available, so hopefully you won't
miss the above 4 that are not (yet?) possible.

### Selectively enable Alt mappings

If you're [aware of the issues](#this-plugin-is-experimental) that `Alt`
mappings can do, and still wanna use *some* of them selectively, here's how you
can do that.

- you do **not** need to have this plugin installed
- choose a character you're sure won't cause you problems in macros or
mappings, for example `x`. It's unlikely you'll ever have `<Esc>x` in your
macros or mappings.
- enable `<M-x>` mapping by putting the following in `.vimrc`

    `set <M-x>=\<Esc>x`

- map `<M-x>` to something useful and use it!

    `map <M-x> :echo "really useful"<cr>`

### Tests

This plugin uses the excellent [vader.vim](https://github.com/junegunn/vader.vim)
Vimscript testing framework.
To run the tests locally:

- install `vader.vim` plugin
- in this project's root directory run `$ test/run`

### Thanks

@tpope for his [rsi.vim](https://github.com/tpope/vim-rsi) plugin, which was an
inspiration for this one.

[soft-wrapping]: http://vimcasts.org/episodes/soft-wrapping-text
