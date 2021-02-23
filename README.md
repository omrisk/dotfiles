# Omrisk's dotfiles
Just my Dot files

## Credit 
[Mathias’s Bynes amazing dotfile repo](https://github.com/mathiasbynens/dotfiles)

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) 
The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/omrisk/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/mathiasbynens/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-L26)) takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```
### Sensible macOS defaults

When setting up a new Mac, you may want to set some sensible macOS defaults:

```bash
./.macos
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](https://brew.sh/) formulae (after installing Homebrew, of course):

```bash
./brew.sh
```

Some of the functionality of these dotfiles depends on formulae installed by `brew.sh`. If you don’t plan to run `brew.sh`, you should look carefully through the script and manually install any particularly important ones. A good example is Bash/Git completion: the dotfiles use a special version from Homebrew.

# Intellij IDE settings
Since Intellij has it's own settings backup and sync methods, I've backed them up to [this private repository](https://github.com/omrisk/intellij-settings).
Linking this here for self reference.
