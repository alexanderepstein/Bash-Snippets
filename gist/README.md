# gist - Manage your gist like a pro
- [Getting started](#Getting-started)
- [Basic Commands](#Basic-Commands)
    - [Update and clone gists from Github](#Update-and-clone-gists-from-Github)
    - [List your gists](#List-your-gists)
    - [Create a new gist](#Create-a-new-gist)
    - [Modify a gist](#Modify-a-gist)
    - [Clean unnecessary local repos](Clean-unnecessary-local-repos)
- [Configuration](#Configuration)
- [Filter gists](#Filter-gists)
    - [Filter by tags](#Filter-by-tags)
    - [Filter by file languages](#Filter-by-file-languages)
    - [Filter by pattern](#Filter-by-pattern)
- [Tips](#Tips)
    - [Filter gists with pipe](#Filter-gists-with-pipe)
    - [Git Branching](#Git-Branching)
    - [Suppress action](#Suppress-action)
    - [Useful action for gist repo](#Useful-action-for-gist-repo)
    - [Suppress hint](#Suppress-hint)

## Getting started
```bash
# fetch your gists and clone them into ~/gist as git repos
gist fetch
# show the list of your gists
gist
# create a new gist
gist new
# create private gist with files 'foo' and 'bar'
gist new -p foo bar
# get the path and cd to cloned repo with subshell
gist 3
# push changes in your third gist to the remote repo
gist push 3
# update the description of your third gist
gist edit 3
# add tags to your third gist
gist tag 3
# list your gists with tags instead of URL
gist tag
# delete gists with indices 3, 4 and 5
gist delete 3 4 5
# or use Brace Expansion
gist delete {3..5}
# Import your third gist as a new Github repo with web page
gist github 3
# For more detail, read the helper message
gist help
```

## Basic Commands
### Update and clone gists from Github
Run `gist fetch` to fetch your all gists with Github API and keep short information for each gist in a index file inside a given folder. (default to `~/gist/index`)
- Automatically Clone/Pull each gist with git into a given folder. (default to `~/gist/`)
- Run `gist fetch star` to fetch you starred gist
- If token is not being set, then you cannot fetch your private gist

### List your gists
Run `gist` to read index file (default to `~/gist/index`) and list your gists with the following format:
```
<index> <gist-URL> <files-number> <comments-number> <description>
```

like the following:

![](https://i.imgur.com/ZCLGZLW.png)

- Use `gist star` to show your starred gists
- Use `gist all` to show your and starred gists
- Index with prefix `s` is a starred gist, index with prefix `p` is a private gist
- There are colorful hints for each gist in the following cases:
    - **working** 
      Some changes are made locally but not yet do `git commit`, or you are not in `master` branch
    - **ahead**
      Your local **HEAD** is yet to be applied to upstream
    - **outdated**
      Your local **HEAD** is differs from the last fetched gists, do `gist fetch` to refresh index file and pull if needed
    
### Create a new gist
Run `gist new` to create a new gist
- You can create a new gist with 3 different ways:
    1. type the content by hand, run `gist new`
    2. use existing files, run `gist new <file1> <file2>...`
    3. from STDIN, like `<command> | gist new`
- You can specify filename with `--file`, and description with `--desc`, like `gist new --file new --desc 'a new gist'`
- If you don't specify filename or description, a prompt will shows up!

### Modify a gist
Run `gist <INDEX>` to enter sub-shell with working directory of the given gist index (by default action). You can do some trick with custom action.(See [action](#action) and [Tips](#Tips))

Since now a gist is a local cloned repo, it is your business to do git commit and git push. Use `gist push <INDEX>` is not recommended.

### Clean unnecessary local repos
Say you delete gists with command `gist delete <index-of-gist>...`, the local git repositories are still at `~/gist/`. Run `gist clean` to move them into `/tmp`
    
## Configuration
`gist` stores your configuraion inside `~/.config/gist.conf`, with `<key>=<value>` format for each line. And just do `source ~/.config/gist.conf` at runtime. 

This file is created automatically when you use `gist` at the first time, it only allows current user to read and write (permission 600).

Valid keys are [`user`](#user), [`token`](#token), [`folder`](#folder), [`auto_sync`](#auto_sync), [`action`](#action), [`EDITOR`](#EDITOR) and [`protocol`](#protocol). Use the following commands to set value:
``` bash
gist config <key> <value>

# Remove current value from a key
gist config <key>

# Or just modify ~/.config/gist.conf directly
gist config
```
Each key is for the following use cases:

### user
Your Github username

If you use command which needs username and `user` is not being set, a prompt will shows up and requires your username and API [`token`](#token). 

Use `gist config user <your-github-username>` to set the value if needed.

### token
Your Github API token for the given username. It's scope should be with `gist`.

If you use command which needs it and it is not being set, A prompt will shows up and requires it. You can choose going to web page to create a new token, or just input an existing one directly.

Use `gist config toekn <your-github-api-token>` to set the value if needed.

### folder 
**[Optional]** The folder you stores index file and git repos for each your gists and starred gists. Default to `~/gist/` if not being set.

Use `gist config folder <prefered-directory>` to set the value if needed.

### auto_sync
**[Optional]** Automatically clone/update your gists and starred gists as git repos when doing `gist fetch`. Default to be `true`.

Use `gist config auto_sync false` to disable this feature.

### action
**[Optional]** A custom action is performed when you do `gist <INDEX>` (like `gist 3` for your third gist). If is being set, `gist` will `cd` to the cloned repo, and just simply use `eval` to perform action.

For example, you can use the following command to
**print the filename and its content of all files inside the given gist**
```bash
gist config action 'tail -n +1 *'
```

If action is not being set, then a default action will be performed:
```bash
# Enter sub-shell with current shell or bash
${SHELL:-bash}
```

Also, if you run `gist <INDEX>` with `--no-action`, then action would be ignored.

### EDITOR
**[Optional]** Editor to open `~/.config/gist.conf`. Default to be `vi` . 

For example, use `gist config EDITOR code` to use VSCode instead.

### protocol
**[Optional]** Protocol to clone git repo. Default to HTTPS
valid values are:
- https
- ssh

For example, use `gist config protocol ssh` to use SSH protocol instead.

## Filter gists
### Filter by tags
`gist` treats **trailing hashtags** inside gist description as tags. For example, if a description s:
```
[Title] this is description #tag1 #tag2
```
When [`gist`](#List-your-gists) is performed, it only display description with part: `[Title] this is description`, and treat the trailing hashtags as tags of a gist.

#### Tag a gist
You can use the following command to add/remove tags:
```bash
# tag your third gist
gist tag 3
```
After it is finished, `gist` just calls Github API to apply new description onto the given gist.

#### Display list with tags
Use sub-command `tag` to show the list of gists with tags instead of URLs.
```bash
# show tags for your gists
gist tag
```
![](https://i.imgur.com/6IqxQjA.png)

#### Filter gists with tags
If arguments after `gist tag` are not indices of gist, then they will be treated as tag values. The output will be a list of gists with those tags
```bash
# Filter gists with tag1 and tag2
gist tag tag1 tag2
```
![](https://i.imgur.com/rchqMN1.png)

#### Pin/Unpin tags
Say you are working with gists with some meaningful tags. You can use sub-command `pin` to pin them, and filter your gists with pinned tags
```bash
# Pin tag1 and tag2, If a tag is pinned, then unpin it
gist pin tag1 tag2
# Disply gists with pinned tags
gist pin
```
![](https://i.imgur.com/LuEjNry.png)

#### Show existing tags
Use sub-command `tags` to show existing tags and pinned tags. They are sorted alphabetically.
```bash
gist tags
```
![](https://i.imgur.com/PuwmaK4.png)

### Filter by pattern
You can search gists with pattern in description, filename or file contents with sub-command `grep`
```bash
# search by a simple string
gist grep string
# search by a pattern(heading string in a line)
gist grep '^string'
```

## Filter by file languages
#### Display list with languages
You can use sub-command `lan` to show the list of gists with file languages instead of URLs.
```bash
# show languages for your gists
gist lan
```
![](https://i.imgur.com/QAS7ZRE.png)

#### Filter gists with languages
```bash
# Filter gists with files in Shell and Yaml format
gist lan
```
![](https://i.imgur.com/tKI5KND.png)

### Index Range
You can specify the range of indices, works both on your owned gists and starred gists.
```bash
# only show gists with index 5 to 10
gist 5-10
# show gists from index 5
gist 5-
# show starred gists only to index s10
gist -s10
# only show gists with index 1 to 20
seq 20 | gist
```

## Tips

### Filter gists with pipe
If `STDIN` is from a pipe, then `gist` will only process gists with **indices in the first column**. So, you can concatenate the output of each sub-command.
```bash
# only show gists with index 1 to 20
seq 20 | gist
# Show the list of starred gist with Yaml file
gist star | gist lan Yaml
# Only show the list of gists with tag1, pattern1 in description/filenames/contents and markdown file
gist tag tag1 | gist grep pattern1 | gist lan SHELL
```

### Git Branching
Each gist is a git repository. Although there are some limits on `git push`, like sub-directory. But guess what? Push another branch to `github.com` is allowed. So why not use this feature for your gist workflow?
 
### Useful action for gist repo
I strongly recommend using [`tig`](https://github.com/jonas/tig) as your custom [action](#action). It is the most powerful git CLI tool as far as I know, and also easy to get in most of the Linux distros or Homebrew for mac. Give it a try!

If [`tig`](https://github.com/jonas/tig) is installed, run the following command to configure it as custom action:

```bash
gist config action 'tig -all'
```
`tig` interface for history diagram:
![](https://i.imgur.com/ju37MgW.png)


### Suppress action
If [`action`](#action) is not being set, you will enter sub-shell by default. If you want suppress it and do not want to type `--no-action` every time, just use command `ture` to do nothing.
```
gist config action 'true'
```
 
### Suppress hint
There are several environment variables or arguments can suppress hint or user confirm, like:
```bash
# show list without hint
hint=false gist

# just print the repo path with a given index
gist 3 --no-action

# delete your third gist without confirmation
gist delete 3 --force
```
