#!/usr/bin/env bash
#
# Author: Hsieh Chin Fan (typebrook) <typebrook@gmail.com>
# License: MIT
# https://gist.github.com/typebrook/b0d2e7e67aa50298fdf8111ae7466b56
#
# --
# gist
# Description: Manage your gists with git and Github API v3
# Usage: gist [command] [<args>]
#
#   [star|s|all|a]                List your gists, use 'star' or 's' for your starred gists,
#                                 'all' or 'a' for both your and starred gists. Format for each line is:
#                                 <INDEX> <URL> <FILE_NUM> <COMMENT_NUM> <DESCRIPTION>
#   fetch,  f [star|s]            Update the local list of your gists, 'star' for your starred gists
#   <INDEX> [-n|--no-action]         Show the path of local gist repo and do custom actions(enter sub-shell by default)
#   new,    n [-d |--desc <description>] [-p] <FILE>...      create a new gist with files
#   new,    n [-d |--desc <description>] [-p] [-f|--file <FILE_NAME>] create a new gist from STDIN
#   grep,   g <PATTERN>           Grep gists by description, filename and content with a given pattern
#   tag,    t <INDEX>             Modify tags for a gist
#   tag,    t <TAG>...            Grep gists with tags
#   tag,    t                     List gist with tags and pinned tags
#   tags,   tt                    List all tags and pinned tags
#   pin,    p <TAG>...            Pin/Unpin tags
#   pin,    p                     Grep gists with pinned tags
#   lan,    l <PATTERN>...        Grep gists with languages
#   lan,    l                     List gist with languages of files
#   detail, d <INDEX>             Show the detail of a gist
#   edit,   e <INDEX> ["NEW_DESCRIPTRION"]  Edit a gist's description
#   delete, D <INDEX>... [--force]          Delete gists by given indices
#   push,   P <INDEX>             Push changes by git (well, better to make commit by youself)
#   clean,  C                     Clean local repos of removed gists
#   config, c [token|user|folder|auto_sync|EDITOR|action|protocol|show_untagged [value]]  Do configuration
#   user,   u <USER>              Get list of gists with a given Github user
#   github, G <INDEX>             Export selected gist as a new Github repo
#   help,   h                     Show this help message
#   version                       Get the tool version
#   update                        Update Bash-Snippet Tools
# 
# Example:
#   gist fetch              (update the list of gists from github.com)
#   gist                    (Show your gists)
#   gist 3                  (show the repo path of your 3rd gist, and do custom actions)
#   gist 3 --no-action      (show the repo path of your 3rd gist, and do not perform actions)
#   gist new foo bari       (create a new gist with files foo and bar)
#   gist tag                (Show your gists with tags)
#   gist tag 3              (Add tags to your 3rd gist)
#   gist tag .+             (show tagged gists)
# 
# Since now a gist is a local cloned repo
# It is your business to do git commit and git push

# TODO Named temp file
# TODO feature to exclude tag-value or grep-string
# TODO codebase statistics, like C++ or something
# TODO migrate to gh-page, with install.sh and check_md5 in README

currentVersion="1.23.0"
configuredClient=""

NAME=${GISTSCRIPT:-$(basename "$0")} #show hint and helper message with current script name
GITHUB_API=https://api.github.com
CONFIG=~/.config/gist.conf; mkdir -p ~/.config

INDEX_FORMAT=('index' 'url' 'tags_string' 'blob_code' 'file_array' 'file_num' 'comment_num' 'author' 'created_at' 'updated_at' 'description')
TAG_CHAR='-_[:alnum:]'
if [[ ! -t 0 ]]; then
  INPUT=$(cat)
  export mark=.
else
  export mark=[^s] # By defaut, only process user's gists, not starred gist
fi

# Default configuration
[[ ! -t 1 && -z $hint ]] && hint=false
auto_sync=true # automatically clone the gist repo
protocol=https

# Shell configuration
set -o pipefail
[[ $TRACE == 'true' ]] && set -x

# clean temporary files
tmp_dir=$(mktemp -d)
trap "[[ '$DEBUG' == 'true' ]] && find  $tmp_dir -type f | xargs tail -n +1 > log; rm -r $tmp_dir" EXIT

# Mac compatibility
tmp_file() {
  if [[ $(uname) == Darwin ]]; then 
    file=$(mktemp) && mv $(mktemp) "$tmp_dir" && echo "$tmp_dir"/$(basename "$file")
  else
    mktemp -p "$tmp_dir"
  fi
}
tac() {
  if [[ $(uname) == Darwin ]]; then 
    tail -r
  else
    $(which tac)
  fi
}
mtime() {
  if [[ $(uname) == Darwin ]]; then 
    stat -x "$1" | grep Modify | cut -d' ' -f2- 
  else
    stat -c %y "$1"
  fi
}

# This function determines which http get tool the system has installed and returns an error if there isnt one
getConfiguredClient() {
  if  command -v curl &>/dev/null; then
    configuredClient="curl"
  elif command -v wget &>/dev/null; then
    configuredClient="wget"
  elif command -v http &>/dev/null; then
    configuredClient="httpie"
  else
    echo "Error: This tool requires either curl, wget, or httpie to be installed." >&2
    return 1
  fi
}

# Allows to call the users configured client without if statements everywhere
# TODO return false if code is not 20x
http_method() {
  local METHOD=$1; shift
  local header_opt; local header; local data_opt
  case "$configuredClient" in
    curl)   [[ -n $token ]] && header_opt="--header" header="Authorization: token $token"
      [[ $METHOD =~ (POST|PATCH) ]] && data_opt='--data'
      curl -X "$METHOD" -A curl -s $header_opt "$header" $data_opt "@$http_data" "$@" ;;
    wget)   [[ -n $token ]] && header_opt="--header" header="Authorization: token $token"
      [[ $METHOD =~ (POST|PATCH) ]] && data_opt='--body-file'
      wget --method="$METHOD" -qO- $header_opt "$header" $data_opt "$http_data" "$@" ;;
    httpie) [[ -n $token ]] && header="Authorization:token $token"
      [[ $METHOD =~ (POST|PATCH) ]] && data_opt="@$http_data"
      http -b "$METHOD" "$@" "$header" "$data_opt" ;;
  esac 2>&1 \
  | tee $(tmp_file) \
  || { echo "Error: no active internet connection" >&2; return 1; }
}

httpGet() {
  http_method GET "$@"
}

# Parse JSON from STDIN with string of python commands
_process_json() {
    PYTHONIOENCODING=utf-8 \
    python -c "from __future__ import print_function; import sys, json; $1"
    return "$?"
}

update() {
  # Author: Alexander Epstein https://github.com/alexanderepstein
  # Update utility version 2.2.0
  # To test the tool enter in the defualt values that are in the examples for each variable
  repositoryName="Bash-Snippets" #Name of repostiory to be updated ex. Sandman-Lite
  githubUserName="alexanderepstein" #username that hosts the repostiory ex. alexanderepstein
  nameOfInstallFile="install.sh" # change this if the installer file has a different name be sure to include file extension if there is one
  latestVersion=$(httpGet https://api.github.com/repos/$githubUserName/$repositoryName/tags | grep -Eo '"name":.*?[^\\]",'| head -1 | grep -Eo "[0-9.]+" ) #always grabs the tag without the v option

  if [[ $currentVersion == "" || $repositoryName == "" || $githubUserName == "" || $nameOfInstallFile == "" ]]; then
    echo "Error: update utility has not been configured correctly." >&2
    exit 1
  elif [[ $latestVersion == "" ]]; then
    echo "Error: no active internet connection" >&2
    exit 1
  else
    if [[ $latestVersion != "$currentVersion" ]]; then
      echo "Version $latestVersion available"
      echo -n "Do you wish to update $repositoryName [Y/n]: "
      read -r answer
      if [[ $answer == [Yy] ]]; then
        cd ~ || { echo 'Update Failed'; exit 1; }
        if [[ -d  ~/$repositoryName ]]; then rm -r -f $repositoryName || { echo "Permissions Error: try running the update as sudo"; exit 1; } ; fi
        echo -n "Downloading latest version of: $repositoryName."
        # shellcheck disable=SC2015
        git clone -q "https://github.com/$githubUserName/$repositoryName" && touch .BSnippetsHiddenFile || { echo "Failure!"; exit 1; } &
        while [ ! -f .BSnippetsHiddenFile ]; do { echo -n "."; sleep 2; };done
        rm -f .BSnippetsHiddenFile
        echo "Success!"
        cd $repositoryName || { echo 'Update Failed'; exit 1; }
        git checkout "v$latestVersion" 2> /dev/null || git checkout "$latestVersion" 2> /dev/null || echo "Couldn't git checkout to stable release, updating to latest commit."
        chmod a+x install.sh #this might be necessary in your case but wasnt in mine.
        ./$nameOfInstallFile "update" || exit 1
        cd ..
        rm -r -f $repositoryName || { echo "Permissions Error: update succesfull but cannot delete temp files located at ~/$repositoryName delete this directory with sudo"; exit 1; }
      else
        exit 1
      fi
    else
      echo "$repositoryName is already the latest version"
    fi
  fi
}

# Handle configuration cases
_configure() {
  [[ $# == 0 ]] && (${EDITOR:-vi} "$CONFIG") && return 0

  local valid_keys='user|token|folder|auto_sync|EDITOR|action|protocol|show_untagged'
  local key=$1; local value="$2"

  [[ ! $key =~ ^($valid_keys)$ ]] \
  && echo "Not a valid key for configuration, use <$valid_keys> instead." \
  && return 1

  case $key in
    user)
      [[ -z $value ]] && echo 'Must specify username' >&2 && return 1 ;;
    token)
      [[ -n $value && ${#value} -ne 40 && ! $value =~ ^(\$|\`) ]] && echo 'Invalid token format, it is not 40 chars' >&2 && return 1 ;;
    auto_sync | show_untagged)
      [[ ! $value =~ ^(true|false)$ ]] && echo "$key must be either true or false" >&2 && return 1 ;;
    protocol)
      [[ ! $value =~ ^(https|ssh)$ ]] && echo 'protocol must be either https or ssh' >&2 && return 1 ;;
    action)
      value="'$2'"
  esac

  umask 0077 && touch "$CONFIG"
  local target=$key="$value"
  sed -i'' -e "/^$key=/ d" "$CONFIG" && [[ -n $target ]] && echo "$target" >> "$CONFIG"
  cat "$CONFIG"
}

# Prompt for username
_ask_username() {
  while [[ ! $user =~ ^[[:alnum:]]+$ ]]; do
    [[ -n $user ]] && echo "Invalid username"
    read -r -p "Github username: " user < /dev/tty
  done
  _configure user "$user"
}

# Prompt for token
# TODO check token scope contains gist, ref: https://developer.github.com/v3/apps/oauth_applications/#check-a-token
_ask_token() {
  echo -n "Create a new token from web browser? [Y/n] "
  read -r answer < /dev/tty
  if [[ ! $answer =~ ^(N|n|No|NO|no)$ ]]; then
    python -mwebbrowser https://github.com/settings/tokens/new?scopes=gist
  fi

  while [[ ! $token =~ ^[[:alnum:]]{40}$ ]]; do
    [[ -n $token ]] && echo "Invalid token"
    read -r -p "Paste your token here (Ctrl-C to skip): " token < /dev/tty
  done
  _configure token "$token"
}

# Check configuration is fine with user setting
_validate_config() {
  # shellcheck source=/dev/null
  source "$CONFIG" 2> /dev/null
  [[ $1 =~ ^(c|config|h|help|u|user|update|version) ]] && return 0
  if [[ -z $user ]]; then
    echo 'Hi fellow! To access your gists, I need your Github username'
    echo "Also a personal token with scope which allows \"gist\"!"
    echo
    _ask_username && _ask_token && init=true
  elif [[ -z $token && $1 =~ ^(n|new|e|edit|D|delete)$ ]]; then
    _ask_token && return 0
    echo 'To create/edit/delete a gist, a token is needed' && return 1
  elif [[ -z $token && $1 =~ ^(f|fetch)$ && $2 =~ ^(s|star)$ ]]; then
    _ask_token && return 0
    echo 'To get user starred gists, a token is needed' && return 1
  fi
}

# Load configuration
_apply_config() {
  _validate_config "$@" || return 1

  [[ -z $folder || ! -w $(dirname "$folder") ]] && folder=~/gist; mkdir -p $folder
  INDEX=$folder/index; [[ -e $INDEX ]] || touch $INDEX
  getConfiguredClient
}

# extract trailing hashtags from description
_trailing_hashtags() {
  grep -Eo " #[$TAG_CHAR #]+$" <<<"$1" | sed -Ee "s/.* [$TAG_CHAR]+//g"
}

_color_pinned_tags() {
  local pinned_tags=( $pin )
  pattern='('$(sed -E 's/ /[[:space:]]|/g; s/\./[^ ]/g; s/$/[[:space:]]/' <<<"${pinned_tags[@]/#/#}")')'
  sed -E -e "s/$pattern/\\\e[33m\1\\\e[0m/g" <<<"$1 "
}

_color_description_title() {
  sed -E -e 's/^\[(.+)\]/\\e[33m[\1]\\e[0m/' <<<"$1"
}

# Return git status of a given repo
_check_repo_status() {
    if [[ ! -d $1 ]]; then
      if [[ $auto_sync == 'true' ]]; then
        echo "\e[32m[cloning]\e[0m";
      else
        echo "\e[32m[Not cloned yet]\e[0m";
      fi
    else
      cd "$1" || exit 1
      # git status is not clean or working on non-master branch
      if [[ -n $(git status --short) || $(cat .git/HEAD) != 'ref: refs/heads/master' ]] &>/dev/null; then
        echo "\e[36m[working]\e[0m"
      else
        # files contents are not the same with the last time called GIST API, so warn user to call 'gist fetch'
        [[ $(_blob_code "$1") != "$2" ]] 2>/dev/null && local status="\e[31m[outdated]\e[0m"
        # current HEAD is newer than remote, warn user to call 'git push'
        [[ -n $(git cherry) ]] 2>/dev/null && local status="\e[31m[ahead]\e[0m"
        echo "$status"
      fi
    fi
}

# check given index is necessary to handle
_index_pattern() {
  if [[ -z "$INPUT" ]]; then 
    echo .+
  else
    echo "($(echo "$INPUT" | sed -Ee '/^ {4,}/ d; s/^ *//; /^$/ q' | cut -d' ' -f1 | xargs | tr ' ' '|'))"
  fi
}

_show_hint() {
  if [[ $display == 'tag' && -n $pin ]]; then
    local pinned_tags=( $pin )
    echo > /dev/tty
    echo Pinned tags: "${pinned_tags[*]/#/#} " > /dev/tty
  elif [[ $hint != 'false' ]]; then
    local mtime="$(mtime $INDEX | cut -d'.' -f1)"
    echo > /dev/tty
    echo "Last updated at $mtime" > /dev/tty
    echo "Run \"$NAME fetch\" to keep gists up to date, or \"$NAME help\" for more details" > /dev/tty
  fi
}

# Display the list of gist, show username for starred gist
# If hint=false, do not print hint to tty. If mark=<pattern>, filter index with regex
# If display=tag/language, print tags/languages instead or url
_show_list() {
  if [[ ! -s $INDEX ]]; then
    echo "Index file is empty, please run commands ""$NAME" fetch" or ""$NAME" create""
    return 0
  fi

  sed -Ee "/^$mark/ !d; /^$(_index_pattern) / !d" $INDEX \
  | while read -r "${INDEX_FORMAT[@]}"; do
    local message=$url
    if [[ $display == 'tag' ]]; then
      local tags=( ${tags_string//,/ } ); message="${tags[@]}"
      [[ $show_untagged == 'false' && ${#tags[@]} == '0' ]] && continue
      local width=45; local align=' ';
    elif [[ $display == 'language' ]]; then
      message="$(tr ',' '\n' <<< "$file_array" | sed -Ee 's/.+@/#/' | uniq | xargs)"
      local width=45; local align=' ';
    fi

    local extra="$(printf "%-4s" "$file_num $comment_num")"
    local status=''; status=$(_check_repo_status "$folder/${url##*/}" "$blob_code")
    [[ $index =~ ^s ]] && description="$(printf "%-12s" ["${author}"]) ${description}"

    raw_output="$(printf "%-3s" "$index") $(printf "%${align:--}${width:-56}s" "$message") $extra ${status:+${status} }$(_color_description_title "$description")"
    [[ -n $pin ]] && raw_output="$(_color_pinned_tags "$raw_output")"
    decorator=$(( $(grep -o '\\e\[0m' <<<"$raw_output" | wc -l) *9 ))
    echo -e "$raw_output" | cut -c -$(( $(tput cols) +decorator ))
  done

  [[ -z $INPUT ]] && _show_hint || true
}

# Grep description, filename or file content with a given pattern
# TODO add option to configure case-sensitive
_grep_content() {
  if [[ -z $1 ]]; then echo 'Please give a pattern' && return 1; fi

  sed -Ee "/^$(_index_pattern) / !d" $INDEX \
  | while read -r "${INDEX_FORMAT[@]}"; do
    # grep from description
    if grep --color=always -iq "$1" <<<"$description"; then
      hint=false mark="$index " _show_list
    else
      local repo=$folder/${url##*/}
      [[ -d $repo ]] && cd "$repo" || continue
      # grep from filenames
      local file=$(ls "$repo" | grep --color=always -Ei "$1")
      # grep from content of files
      # Abort error message to prevent weird file name, for example: https://gist.github.com/6057f4a3a533f7992c60
      local content=$(grep --color=always -EHi -m1 "$1" * 2>/dev/null | head -1)

      [[ -n $file && file="$file\n" || -n $content ]] \
      && hint=false mark="$index " _show_list \
      && echo -e "    $file$content"
    fi
  done
}

# Parse JSON object of the result of gist fetch
_parse_gists() {
    _process_json '
raw = json.load(sys.stdin)
for gist in raw:
    print(gist["html_url"], end=" ")
    print(gist["public"], end=" ")
    print(",".join(file["raw_url"] for file in gist["files"].values()), end=" ")
    print(",".join(file["filename"].replace(" ", "-") + "@" + str(file["language"]).replace(" ", "-") for file in gist["files"].values()), end=" ")
    print(len(gist["files"]), end=" ")
    print(gist["comments"], end=" ")
    print(gist["owner"]["login"], end=" ")
    print(gist["created_at"], end=" ")
    print(gist["updated_at"], end=" ")
    print(gist["description"])
    '
}

# Parse response from 'gist fetch' to the format for index file
_parse_response() {
  _parse_gists \
  | tac | nl -s' ' \
  | while read -r "${INDEX_FORMAT[@]:0:2}" public file_url_array "${INDEX_FORMAT[@]:4:7}"; do
    local private_prefix=''; [[ $public == 'False' ]] && private_prefix=p
    [[ -n $1 ]] && local index=${1}; index=${private_prefix}${prefix}${index}

    local blob_code=$(echo "$file_url_array" | tr ',' '\n' | sed -E -e 's#.*raw/(.*)/.*#\1#' | sort | cut -c -7 | paste -s -d '-' -)
    file_array=${file_array//@None/@Text}

    local hashtags_suffix="$(_trailing_hashtags "$description")"
    description="${description%"$hashtags_suffix"}"
    local hashtags="$(echo "$hashtags_suffix" | xargs)"
    local tags_string="${hashtags// /,}"; [[ -z $tags_string ]] && tags_string=','

    eval echo "${INDEX_FORMAT[@]/#/$}"
  done
}

# Get latest list of gists from Github API
# TODO pagnation for more than 100 gists
_fetch_gists() {
  echo "fetching $user's gists from $GITHUB_API..."
  echo
  local route="users/$user/gists"
  local prifix=''
  if [[ $mark == s ]]; then
    route='gists/starred'
    prefix=s
  fi

  result=$(http_method GET $GITHUB_API/$route?per_page=100 | prefix=$prefix _parse_response)
  [[ -z $result ]] && echo 'Not a single valid gist' && return 0

  sed -i'' -Ee "/^$mark/ d" $INDEX && echo "$result" >> $INDEX
  hint=$hint _show_list

  [[ $auto_sync == 'true' ]] && (_sync_repos &> /dev/null &)
  true
}

# Fetch gists for a given user
# TODO pagnation for more than 100 gists
_query_user() {
  local route="users/$1/gists"
  result="$(http_method GET $GITHUB_API/"$route"?per_page=100 | _parse_response)"
  [[ -z $result ]] && echo "Failed to query $1's gists" && return 1

  echo "$result" \
  | while read -r "${INDEX_FORMAT[@]}"; do
    echo "$url $author $file_num $comment_num $description" | cut -c -"$(tput cols)"
  done
}

# Return the unique code for current commit, to compare repo status and the result of 'gist fetch'
# Because there is no way to get commit SHA with 'gist fetch'
_blob_code() {
  cd "$1" && git ls-tree master | cut -d' ' -f3 | cut -c-7 | sort | paste -sd '-'
}

_pull_if_needed() {
  sed -ne "/$1 / p" "$INDEX" \
  | while read -r "${INDEX_FORMAT[@]}"; do
    local repo; repo=$folder/$1
    local blob_code_local; blob_code_local=$(_blob_code "$repo")
    cd "$repo" \
    && [[ $blob_code_local != "$blob_code" ]] \
    && [[ $(git rev-parse origin/master) == $(git rev-parse master) ]] \
    && git pull &
  done
}

# Update local git repos
_sync_repos() {
  comm -1 <(ls -A "$folder" | sort) \
          <(cut -d' ' -f1-2 < "$INDEX" | sed -ne "/^$mark/ s#.*/##p" | sort) \
  | {
    result=$(cat)

    # clone repos which are not in the local
    sed -ne '/^\t/ !p' <<<"$result" \
    | xargs -I{} --max-procs 8 git clone "$(_repo_url {})" $folder/{} &

    # if repo is cloned, do 'git pull' if remote repo has different blob objects
    sed -ne '/^\t/ s/\t//p' <<<"$result" \
    | while read GIST_ID; do
      _pull_if_needed "$GIST_ID"
    done
  }
}

# Get the url where to clone repo, take user and repo name as parameters
_repo_url() {
  if [[ $protocol == 'ssh' ]]; then
    echo "git@gist.github.com:$1.git"
  else
    echo "https://gist.github.com/$1.git"
  fi
}

# Get gist id from index files
_gist_id() {
  GIST_ID=$(sed -En -e "/^$1 / s#^$1 [^ ]+/([[:alnum:]]+) .+#\1#p" $INDEX | head -1)
  if [[ -z $GIST_ID || ! $1 =~ [0-9a-z]+ ]]; then
    echo -e "$(hint=false _show_list | sed -Ee 's/^( *[0-9a-z]+)/\\e[5m\1\\e[0m/')"
    echo
    echo -e "Invalid index: \e[33m$1\e[0m"
    echo 'Use the indices blinking instead (like 1 or s1)'
    return 1
  fi
}

# set gist id either by given index or current directory
_set_gist_id() {
  if [[ -z $1 ]]; then
    [[ $(dirname $(pwd)) == $folder ]] && GIST_ID=$(basename $(pwd)) && return 0
  fi
  _gist_id "$1" || return 1
}

# Show path of repo by gist ID, and perform action
_goto_gist() {
  echo "$folder/$GIST_ID"
  touch "$folder/$GIST_ID"

  if [[ $* =~ (-n|--no-action) ]]; then
    return 0
  elif [[ -z $action ]]; then
    action='echo Inside subshell, press \<CTRL-D\> to exit; ${SHELL:-bash}'
  fi

  cd "$folder/$GIST_ID" && eval "$action"
}

# Return the path of local repo with a given index
_goto_gist_by_index() {
  _gist_id "$1" || return 1

  if [[ ! -d $folder/$GIST_ID  ]]; then
    echo 'Cloning gist as repo...'
    if git clone "$(_repo_url "$GIST_ID")" "$folder/$GIST_ID"; then
      echo 'Repo is cloned' > /dev/tty
    else
      echo 'Failed to clone the gist' > /dev/tty
      return 1
    fi
  fi

  _goto_gist "$@"
}

# Delete gists with given indices
# Specify --force to suppress confirmation
_delete_gist() {
  if [[ ! $* =~ '--force' ]]; then
    read -r -p "Delete gists above? [y/N] " response
    response=${response,,}
    [[ ! $response =~ ^(yes|y)$ ]] && return 0
  fi

  for i in "$@"; do
    _gist_id "$i" &> /dev/null || continue
    http_method DELETE "$GITHUB_API/gists/$GIST_ID" \
    && echo "$i" deleted \
    && sed -E -i'' -e "/^$i / d" $INDEX
  done
}

# Remove repos which are not in index file anymore
_clean_repos() {
  comm -23 <(find $folder -maxdepth 1 -type d | sed -e '1d; s#.*/##' | sort) \
           <(cut -d' ' -f2 < "$INDEX" | sed -e 's#.*/##' | sort 2> /dev/null ) \
  | while read -r dir; do
    mv $folder/"$dir" /tmp && echo $folder/"$dir" is moved to /tmp
  done
}

# Parse JSON object of gist user comments
_parse_comment() {
  _process_json '
raw = json.load(sys.stdin);
for comment in raw:
    print()
    print("|", "user:", comment["user"]["login"])
    print("|", "created_at:", comment["created_at"])
    print("|", "updated_at:", comment["updated_at"])
    print("|", comment["body"])
  '
}

# Show the detail of a gist
# TODO add parameter --comment to fetch comments
_show_detail() {
  _set_gist_id "$1" || return 1

  sed -En -e "/[^ ]+ [^ ]+$GIST_ID / p" $INDEX \
  | while read -r "${INDEX_FORMAT[@]}"; do
    echo -e desc: $(_color_description_title "$description")
    echo -e tags: ${tags_string//,/ }
    echo -e site: https://gist.github.com/"$GIST_ID"
    echo -e API : https://api.github.com/gists/"$GIST_ID"
    echo -e created_at: "$created_at"
    echo -e updated_at: "$updated_at"
    echo -e files:
    tr ',' '\n' <<<"${file_array//@/ }" | column -t | sed -e 's/^/    /'
  done
}

# Open Github repository import page
_export_to_github() {
  _gist_id "$1" || return 1
  echo Put the folowing URL into web page:
  echo -n "https://gist.github.com/$GIST_ID.git"
  python -mwebbrowser https://github.com/new/import
}

# Simply commit current changes and push to remote
_push_to_remote() {
  if [[ ! $(pwd) =~ ^$folder/[0-9a-z]+$ ]]; then
    _gist_id "$1" || return 1
    cd "$folder/$GIST_ID" || exit
  fi
  if [[ -n $(git status --short) ]]; then
    git add . && git commit -m 'update'
  fi
  if [[ -n $(git cherry) ]]; then
    git push origin master && (hint=false _fetch_gists &> /dev/null &)
  fi
}

# Set filename/description/permission for a new gist
_set_gist() {
  files=()
  description=''; filename=''; public=True
  while [[ -n "$*" ]]; do case $1 in
    -d | --desc)
      description="$2"
      shift; shift;;
    -f | --file)
      filename="$2"
      shift; shift;;
    -p)
      public=False
      shift;;
    *)
      files+=($1)
      shift;;
    esac
  done
  ls "${files[@]}" > /dev/null || return 1
}

# Let user type the content of gist before setting filename
_new_file() {
  tmp_file=$(tmp_file)
  if [[ -z $INPUT ]]; then 
    echo "Type a gist. <Ctrl-C> to cancel, <Ctrl-D> when done" > /dev/tty
    cat > "$tmp_file"
  else
    echo "$INPUT" > "$tmp_file"
  fi

  echo > /dev/tty
  [[ -z $1 ]] && read -e -r -p 'Type file name: ' filename < /dev/tty
  mv "$tmp_file" "$tmp_dir"/"$filename"
  echo "$tmp_dir"/"$filename"
}

# Parse JSON object of a single gist 
_gist_body() {
  _process_json "
import os.path
files_json = {}
files = sys.stdin.readline().split()
description = sys.stdin.readline().replace('\n','')
for file in files:
    with open(file, 'r') as f:
        files_json[os.path.basename(file)] = {'content': f.read()}
print(json.dumps({'public': $public, 'files': files_json, 'description': description}))
  "
}

# Create a new gist with files. If success, also update index file and clone the repo
_create_gist() {
  _set_gist "$@" || return 1
  [[ -z ${files[*]} ]] && files+=($(_new_file "$filename"))
  [[ -z $description ]] && read -e -r -p 'Type description: ' description < /dev/tty

  echo 'Creating a new gist...'
  http_data=$(tmp_file)
  echo -e "${files[*]}\n$description" \
  | _gist_body > "$http_data" \
  && http_method POST $GITHUB_API/gists \
  | xargs -I{} -0 echo "[{}]" \
  | _parse_response $(( $(sed -e '/^s/ d' $INDEX | wc -l) +1 )) \
  | tee -a $INDEX \
  | cut -d' ' -f2 | sed -E -e 's#.*/##' \
  | (xargs -I{} git clone "$(_repo_url {})" $folder/{} &> /dev/null &)

  # shellcheck disable=2181
  if [[ $? -eq 0 ]]; then
    echo 'Gist is created'
    INPUT=$(tail -1 $INDEX | cut -d' ' -f1) hint=false _show_list | tail -1
  else
    echo 'Failed to create gist'
  fi
}

# Update description of a gist
_edit_gist() {
  local index=$1; shift
  _gist_id "$index" || return 1

  if [[ -z "$@" ]]; then
    read -r "${INDEX_FORMAT[@]}" <<<"$(sed -ne "/^$index / p" $INDEX)"
    read -e -p 'Edit description: ' -i "$description" -r DESC < /dev/tty
    tags=( ${tags_string//,/ } )
    DESC="$DESC ${tags[*]}"
  else
    DESC="$@"
  fi

  http_data=$(tmp_file)
  echo '{' \"description\": \""${DESC//\"/\\\"}"\" '}' > "$http_data"
  new_record=$(http_method PATCH "$GITHUB_API/gists/$GIST_ID" \
               | sed -e '1 s/^/[/; $ s/$/]/' \
               | _parse_response "${index#[[:alpha:]]}" )
  [[ -n $new_record ]] && sed -i'' -E -e "/^$index / s^.+^$new_record^" $INDEX \
  && hint=false mark="$index " _show_list \
  || echo 'Fail to modify gist description'
}

# Print helper message
usage() {
  sed -Ene "/^#/ !q; 1,/^# --/ d; s/^# //p; s/^( *|Usage: )gist/\1$NAME/" "$0"
}

# Check remote urls of all repos match current protocol in configuration file
# If not, update them
_check_protocol() {
  find $folder -maxdepth 1 -mindepth 1 -type d \
  | while read -r repo; do
    cd "$repo" || exit 1
    url=$(git remote get-url origin)
    if [[ $protocol == 'ssh' && $url =~ ^https ]]; then
      git remote set-url origin "git@gist.github.com:$(basename $(pwd)).git"
    elif [[ $protocol == 'https' && $url =~ ^git ]]; then
      git remote set-url origin "https://gist.github.com/$(basename $(pwd)).git"
    fi
  done
}

_tag_gist() {
  # if no tag is given, show gist list with tags
  if [[ -z $* ]]; then
    display=tag _show_list
  # if user want to change tags of a gist
  elif _gist_id "$1" &>/dev/null; then
    _show_detail "$1" | sed 3,6d && echo
    read -r "${INDEX_FORMAT[@]}" <<<"$(sed -ne "/^$1 / p" $INDEX)"
    local tags="$(sed -e 's/,//g; s/#/ /g; s/^ //g' <<<"$tags_string")"
    read -e -p 'Edit tags: ' -i "$tags" -r -a new_tags < /dev/tty
    local hashtags=( $(sed -Ee 's/#+/#/g' <<<${new_tags[@]/#/#}) ) 
    ($0 edit "$1" "${description}${hashtags:+ }${hashtags[@]}" &>/dev/null &)
  # if user want to filter gists with given tags
  else
    local pattern="($(sed -E 's/([^ ]+)/#\1/g; s/ /[[:space:]]|/g; s/\./[^ ]/g' <<<"$@") )"
    hint=false mark=${INPUT:+.} display=tag _show_list | grep --color=always -E "$pattern"
  fi
}

# show all tags and pinned tags
_show_tags() {
  local pinned_tags=( $pin )
  local tags=$(while read -r "${INDEX_FORMAT[@]}"; do
                 echo ${tags_string//,/ }
               done < $INDEX  | tr ' ' '\n' | sed -e '/^$/d' | sort -u) 

  for prefix in {0..9} {a..z} {A-Z} [^0-9a-zA-Z]; do
    local line=$(echo "$tags" | grep -Eo "#$prefix[^ ]+" | tr '\n' ' ')
    [[ -z $line ]] && continue

    # add color to pinned tags
    echo -e "$(_color_pinned_tags "$line")"
  done

  echo
  if [[ ${#pinned_tags} == 0 ]]; then
    echo "Run \"$NAME pin <tag1> <tag2>...\" to pin/unpin tags"
  else
    echo Pinned tags: "${pinned_tags[@]/#/#}"
  fi
}

# pin/unpin tags
_pin_tags() {
  # if no arguments, print gists with pinned tags
  if [[ -z $* && -n $pin ]]; then
    hint=false _tag_gist "$pin"
  else
    local new_pinned=( $(echo "$pin" "$*" | tr ' ' '\n' | sort | uniq -u | xargs) )
    for tag in "${new_pinned[@]}"; do
      if [[ $tag =~ [p]*[0-9]+ ]]; then 
        echo Invalid tag: "$tag"
        return 1
      fi
    done || exit 1

    pin="${new_pinned[@]}"
    _show_tags
    sed -i'' -e "/^pin=/ d" "$CONFIG" && echo pin=\'"${new_pinned[*]}"\' >> "$CONFIG"
  fi
}

# show languages of files in gists
_gists_with_languages() {
  local pattern="($(sed -E 's/([^ ]+)/#\1/g; s/ /|/g' <<<"$@"))"
  display=language _show_list | grep --color=always -Ei "$pattern"
}

_gists_with_range() {
  [[ ! $* =~ ^s?[0-9]*-s?[0-9]*$ ]] && echo 'Invalid range' && exit 1
  local prefix=''; [[ $* =~ s ]] && prefix=s

  local maximum=$(sed -Ene "/^${prefix:-[^s]}/ p" $INDEX | wc -l)
  local range=$(sed -Ee "s/s//g; s/^-/1-/; s/-$/-$maximum/; s/-/ /" <<< "$*")
  INPUT=$(seq "$range" | sed -e "s/^/p?$prefix/")
  hint=false _show_list
}

_access_last_index() {
  GIST_ID=$(ls -tup $folder | grep / | head -1)
  _goto_gist "$@"
}

_apply_config "$@" || exit 1
if [[ $init ]]; then _fetch_gists; exit 0; fi
case "$1" in
  "")
    _show_list ;;
  star | s)
    mark=s; _show_list ;;
  all | a)
    mark=.; _show_list ;;
  fetch | f)
    [[ $2 =~ ^(s|star)$ ]] && mark=s || mark=[^s]
    _fetch_gists ;;
  new | n)
    shift
    _create_gist "$@" ;;
  edit | e)
    shift
    _edit_gist "$@" ;;
  sync | S)
    _sync_repos ;;
  detail | d)
    shift
    _show_detail "$@" ;;
  delete | D)
    shift
    _delete_gist "$@" ;;
  clean | C)
    _clean_repos ;;
  config | c)
    shift
    _configure "$@" && (_apply_config config && _check_protocol) ;;
  user | u)
    shift
    _query_user "$@" ;;
  grep | g)
    shift
    _grep_content "$@" ;;
  github | G)
    shift
    _export_to_github "$1" ;;
  push | P)
    shift
    _push_to_remote "$1" ;;
  tag | t)
    shift
    _tag_gist "$@" ;;
  tags | tt)
    _show_tags ;;
  pin | p)
    shift
    _pin_tags "$@" ;;
  lan | l)
    shift
    _gists_with_languages "$@" ;;
  *-*)
    mark=.; _gists_with_range "$@" ;;
  last | L)
    _access_last_index "$@" ;;
  version)
    echo "Version $currentVersion" ;;
  update)
    update ;;
  help | h)
    usage ;;
  *)
    _goto_gist_by_index "$@" ;;
esac
