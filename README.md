<img align="right" width="300" alt="zshero" src="https://user-images.githubusercontent.com/48519/44404842-37ea9800-a52e-11e8-8e02-915efa8784ed.png">


# ZsHero

![GitHub tag](https://img.shields.io/github/tag/filipekiss/zshero.svg)
![GitHub release](https://img.shields.io/github/release/filipekiss/zshero/all.svg)
![Maintained](https://img.shields.io/maintenance/yes/2018.svg)
![License](https://img.shields.io/github/license/filipekiss/zshero.svg)

## About ZsHero

ZsHero is a simple helper to manage dotfiles configuration.

## Disclaimer

This is a project under construction. Things are not well documented and
pretty simple right now. Feel free to suggest features or report bugs using
the issue tracker.

### Requirements

-   zsh
-   git
-   stow

### Introduction

Who a hero would be without it's sidekicks, am I right? When it comes to
ZsHero, you're the Hero and `git`, `vim` and many others are your sidekicks.
ZsHero is here to help you manage and version your configuration files.

### Installation

There are two main ways to use ZsHero: as a submodule in your dotfiles
repository or as a shell plugin. In the end, they both work the same way and I
myself use a combination of both.

If you want to use ZsHero as a submodule you can manually add it or you can
use `zshero-installer` in your dotfiles folder to configure the submodule for
you.

#### Using `zshero-installer`

Just run the following command on your repository:

```sh
curl -fsSL https://raw.githubusercontent.com/filipekiss/zshero/master/zshero-installer | zsh
```

If you don't have cURL, you can use wget:

```sh
wget -qO- https://raw.githubusercontent.com/filipekiss/zshero/master/zshero-installer | zsh
```

If you'd rather not run scripts directly you are free to download and inspect
it, or even add the module manually to your repository:

#### Adding ZsHero as a submodule manually

In your repository, run the following command:

```sh
git submodule add https://github.com/filipekiss/zshero.git .zshero
```

Assuming you run this at the root of your repository, ZsHero will be on the
`.zshero` folder.

#### Using Zplug, Zplugin or other plugins manager

ZsHero can also be installed use any of these plugins managers:

##### zplug

```sh
zplug "filipekiss/zshero"
```

#### zplugin

```sh
zplugin light "filipekiss/zshero"
```

Using the plugin managers automatically makes the `zshero` function available
in the interactive shell. If you added ZsHero as a submodule, you'll need to
source the `init.zsh` file to load the `zshero` function.

### Usage

#### Before starting

Assuming you already sourced the `init.zsh` file manually or the plugin
manager sourced it for you, the `zshero` function should be available at your
interactive shell.

Before starting, run `zshero info`. You should see something like this:

```sh
ZsHero - Version 0.5.0
ZSHERO_ROOT = /Users/filipekiss/code/filipekiss/zshero
ZSHERO_HOME = /Users/filipekiss/.dotfiles
ZSHERO_DESTINATION_FOLDER = /Users/filipekiss
ZSHERO_SIDEKICKS_FOLDER = sidekicks
```

##### `ZSHERO_ROOT`

This is where ZsHero was loaded from. This can be your dotfiles repository if
you're using as a submodule or it can be somewhere else if you installed
ZsHero using a plugin manager.

##### `ZSHERO_HOME`

This is where ZsHero will look for configuration files when installing or
where it will add new configuration files when you "adopt" them.

##### `ZSHERO_DESTINATION_FOLDER`

This is where ZsHero will put the links. Usually this is your `$HOME` (and
it's the default value assumed by ZsHero)

##### `ZSHERO_SIDEKICKS_FOLDER`

This is a folder where ZsHero will group your config files. We'll enter into
details later. This path is relative to `$ZSHERO_HOME`.

For the rest of this guide, assume the following tree for the repository where
we'll configure ZsHero:

```sh
$HOME/.dotfiles
├── bin
├── homebrew
└── scripts
```

These are just sample folders and they have nothing to do with ZsHero. I'll
also assume that you already initialized `zshero` and the command is available
for you in the shell (you can check by running `zshero info`)

#### Adding a new configuration to your repository

Now, we'll add our git configuration to the repository. (We'll use git in this
example but you can do this for zsh, vim and basically any configuration file
that lives under `$HOME`. On macOS you can even use configuration files from
`$HOME/Library/Application Support`. ZsHero only cares about file structure,
not file contents).

Let's say we want to add our `$HOME/.gitconfig` file to our repository. Simply
run:

```sh
zshero add git ~/.gitconfig
```

You should see an output like this:

```sh
→ Created git
✔ /Users/filipekiss/.dotfiles/sidekicks/git created
→ Adopting git!
✔ git adopted!
```

If you check your `$HOME/.gitconfig` file, you'll see that now it's just a
link to `$ZSHERO_HOME/$ZSHERO_SIDEKICKS_FOLDER/git/.gitconfig`.

That's it. Now your `.gitconfig` file is managed by ZsHero. You can
`git add sidekicks/git/.gitconfig` and start versioning your changes.

##### Understanding the `zshero add` command

```sh
zshero add git ~/.gitconfig
            │       │
            │       └─────── The file to be added to the repository
            └─────────────── The name of the 'sidekick'
```

The add command is really simple: You tell it which _sidekick_ is responsible
for this configuration file and pass the path for the configuration file.
That's it. ZsHero will copy the file to a folder inside the
$ZSHERO*SIDEKICKS_FOLDER named after the sidekick you chose. So, in the
command above, we're telling ZsHero that the \_sidekick* `git` is responsible
for the `~/.gitconfig` file.

#### Installing configurations from a sidekick

When setting up ZsHero in a new computer, all you need to do after installing
ZsHero and cloning your dotfiles repository, is run the following

```sh
zshero install [sidekick]
```

The _sidekick_ name is optional. If you don't provide a name, all sidekicks
will be installed. But if you run, let's say, `zshero install git`, only the
files for the git _sidekick_ will be added.

---

**ZsHero** © 2018+, Filipe Kiss Released under the [MIT] License.<br> Authored
and maintained by Filipe Kiss

> GitHub [@filipekiss](https://github.com/filipekiss) &nbsp;&middot;&nbsp;
> Twitter [@filipekiss](https://twitter.com/filipekiss)

Logo courtesy of [Aras Atasaygin](https://github.com/arasatasaygin) and the
[Open Logos Project](https://github.com/arasatasaygin/openlogos)

[mit]: LICENSE.md
