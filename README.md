# Just (Visiting)

For when you want your aliases but you're using someone else's computer.

Have you ever paired with someone else, and then gone to type `gco` for `git checkout`, only to be told that the computer has no idea what this `gco` thingo is? Ever wanted to take your aliases with you without forcing you to pollute the terminal environment of whoever you're pairing with?

Just is just for you!

## Installation

```
gem install just
```

Then you should run `just setup` and follow the instructions there.

## Usage

### Add

The first port of call for `just` is the `add` command, which clones down a specified repository. This repository should be fairly light, containing just your aliases.

Here's how to run it:

```
just add radar/dot-files
```

This will add my `dot-files` repository to `~/.just/radar/dot-files`.

### Use

Adding doesn't do anything by default so to make `just` start to use aliases, just use the `use` command:

```
just use radar/dot-files ryan-aliases
```

This will tell `just` to use the `ryan-aliases` file from `radar/dot-files`. And only that file.

You could also specify multiple files:

```
just use radar/dot-files gitaliases ryan-aliases
```

### Me / Reset

When you're done pairing, you can run this command to reset everything back to normal:

```
just me
```

Or:

```
just reset
```

Any aliases added by `just` will be forgotten.





