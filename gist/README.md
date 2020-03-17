# gist - Manage your gist like a pro
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
# get the path of cloned repo of your third gist
gist 3
# cd to the cloned repo
cd `gist 3`
# push changes in your third gist to the remote repo
gist push 3
# update the description of your third gist
gist edit 3
# delete gists with index 3, 4 and 5
gist delete 3 4 5
# or use Brace Expansion
gist delete {3..5}
# Import your third gist as a new Github repo with web page
gist github 3
# For more detail, read the helper message
gist help
```
## Commands
### Update information and clone gists from Github
Run `gist fetch` to fetch your all gists with Github API and keep short information for each gist in a index file inside a given folder. (default to `~/gist/index`)
- Automatically Clone/Pull each gist with git into a given folder. (default to `~/gist/`)
- Run `gist fetch star` to fetch you starred gist
- If token is not being set, then you cannot fetch your private gist

### List your gists
Run `gist` to read index file (default to `~/gist/index`) and list your gists with the folloing format:
``` 
[index] [gist-URL] [files-number] [comments-number] [description]
```
like following:
![](https://i.imgur.com/CP6ZL2G.png)

- Use `gist star` to show your starred gist
- Index with prefix `s` is a starred gist, index with prefix `p` is a private gist
- There are colorful hints for each gist in the following cases:
    - **working:** some changes are made locally but not yet do `git commit`, or you are not in `master` branch
    - **ahead:** your local head is yet to be applied to upstream
    - **outdated:** your local head is differs from the last fetched gists, do `gist fetch` to refresh index file and pull if needed
    
### Create a new gist
Run `gist new` to create a new gist
- You can create a new gist with 3 different ways:
    1. type the content by hand, run `gist new`
    2. use existig files, run `gist new <file1> <file2>...`
    3. from STDIN, like `<command> | gist new`
- You can specify filename with `--file`, and description with `--desc`, like `gist new --file new --desc 'a new gist'`
- If you don't specify filename or description, a prompt will shows up!

### Modify a gist
Run `gist <index-of-gist>` to use default editor to open files in local repo (by default action). Also use `cd $(gist <index-of-gist>)` to cd to that repo. You can do some trick to simplify it.(See [action](#action) and [Tips](#Tips))

Since now a gist is a local cloned repo, it is your business to do git commit and git push. Use `gist push <index-of-gist>` is not recommended.

### Clean unnecessary local repos
Say you delete gists with command `gist delete <index-of-gist>...`, the local git repositories are still at `~/gist/`. Run `gist clean` to move them into `/tmp`
    
## Configuration
`gist` stores your configuraion inside `~/.config/gist.conf`, with `<key>=<value>` format for each line. And just do `source ~/.config/gist.con` at runtime. This file is created automatically when you do the first configuration, and only allows current user to read and write (permission 600).

Valid keys are [`user`](#user), [`token`](#token), [`folder`](#folder), [`auto_sync`](#auto_sync), [`action`](#action), [`EDITOR`](#EDITOR) and [protocol](#protocol). Use the following commads to set value:
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
**[Optional]** A custom action is performed when you do `gist <index-of-gist>` (like `gist 3` for your third gist). If is being set, `gist` will `cd` to the cloned repo, and just simply use `eval` to perform action.

For example, you can use the following command to set the action for:
**print the filename and its content of all files inside the given gist**
```
gist config action 'tail -n +1 *'
```
or do
```
gist config action '${EDITOR:-vi} .'
```
That is, use default editor or vi (if not being set) to open the cloned repo.

Also, if you run `gist <index-of-gist>` with `--no-action`, then action would be ignored.

### EDITOR
**[Optional]** Editor to open `~/.config/gist.conf`. Default to be `vi` . 

For example, use `gist config EDITOR code` to use VSCode instead.

### protocol
**[Optional]** Protocol to clone git repo. Default to HTTPS
valid values are:
- https
- ssh

For example, use `gist config protocol ssh` to use SSH protocol instead.

## Tips
### Git Branching
Each gist is a git repository. Although there are some limits on `git push`, like sub-directory. But guess what? Push another branch to `github.com` is allowed. So why not use this feature for your gist workflow?

### Jump to gist repo
Sometimes you want to switch to the gist repo as working directory with given index.
But since `gist` is a bash script which goes in subshell, if you want to achieve this, it is necessary to configure shell setting by yourself. 

`gist <index-of-gist>` will return the path of repo, so you can put the following function into your `~/.bashrc` or `~/.zshrc` to apply it.
```bash
 function cdgist() {
   local dir=$(gist $1 --no-action)
   [[ -d $dir ]] && cd $dir
 }
 ```
 And run `cdgist 3` to jump to the repo of your third gist.
 
### Suppress hint
If [action](#action) is not configured, there is always a hint to show how to configure it. The following command can suppress it with a simple action that does nothing.
```
gist config action 'true'
```

There are serveral environment variables can suppress hint or user confirm, like:
```
# show list without hint
hint=false gist

# just print the repo path with a given index
gist 3 --no-action

# delete your third gist without confirmation
confirm=false gist delete 3
```


 
### Useful action for gist repo
I strongly recommend using [`tig`](https://github.com/jonas/tig) as [action](#action). It is the most powerful git CLI tool as far as I know, and also easy to get in most of the Linux distros or Homebrew for mac. Give it a try!

If [`tig`](https://github.com/jonas/tig) is installed, run the following command to configure it as custom action:

```
gist config action 'tig -all'
```
