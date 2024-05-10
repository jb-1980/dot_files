#!/usr/bin/env bash

# Inspired by: https://gist.github.com/schacon/e9e743dee2e92db9a464619b99e94eff
# https://www.youtube.com/watch?v=aolI_Rz0ZqY
# This version available from: https://gist.github.com/adamcrews/b39f7db45b920281942c179a4882fb18
# Install by copying this script to some local directory then add an alias to git:
#   git config --global alias.bb '!~/dot_files/include/better-git-branch.sh'


# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
NO_COLOR='\033[0m'

# Function to count commits
count_commits() {
  local branch="$1"
  local base_branch="$2"
  local ahead_behind

  ahead_behind=$(git rev-list --left-right --count "$base_branch"..."$branch")
  echo "$ahead_behind"
}

dashes() {
  local length="$1"
  printf '%*s' "$length" | tr ' ' '-'
}

format_string="%(objectname:short)@%(refname:short)@%(committerdate:relative)"
readarray -t branches_data < <(git for-each-ref --sort=-authordate --format="$format_string" refs/heads/)

# Main script
main_branch=$(git rev-parse --abbrev-ref HEAD)

# Find field lengths
ahead_width=5
behind_width=6
url_width=5
max_branch_width=0
max_age_width=0
max_desc_width=0
desc_found=false
for branch_data in "${branches_data[@]}"; do
  IFS='@' read -r sha branch age <<<"$branch_data"
  if [ "$branch" != "$main_branch" ]; then
    description=$(git config branch."$branch".description)
    if [ -n "$description" ]; then
      desc_found=true
      IFS=$'\n' readarray -t d_lines <<<"$description"
      for d in "${d_lines[@]}"; do
        max_desc_width=$((max_desc_width > ${#d} ? max_desc_width : ${#d}))
      done
    fi

    max_branch_width=$((max_branch_width > ${#branch} ? max_branch_width : ${#branch}))
    max_age_width=$((max_age_width > ${#age} ? max_age_width : ${#age}))
  fi
done

# Header and separator with conditional Description field
header_format="${GREEN}%-${ahead_width}s ${RED}%-${behind_width}s ${BLUE}%-${max_branch_width}s ${YELLOW}%-${max_age_width}s ${PURPLE}%-${url_width}s"
separator_format="${GREEN}%-${ahead_width}s ${RED}%-${behind_width}s ${BLUE}%-${max_branch_width}s ${YELLOW}%-${max_age_width}s ${PURPLE}%-${url_width}s"
if $desc_found; then
  header_format+=" ${NO_COLOR}%-${max_desc_width}s"
  separator_format+=" ${NO_COLOR}%-${max_desc_width}s"
  printf "$header_format\n" "Ahead" "Behind" "Branch" "Last Commit" "PR #" "Description"
  printf "$separator_format\n" "$(dashes $ahead_width)" "$(dashes $behind_width)" "$(dashes $max_branch_width)" "$(dashes $max_age_width)" "$(dashes $url_width)" "$(dashes $max_desc_width)"
else
  printf "$header_format\n" "Ahead" "Behind" "Branch" "Last Commit" "PR #"
  printf "$separator_format\n" "$(dashes $ahead_width)" "$(dashes $behind_width)" "$(dashes $max_branch_width)" "$(dashes $max_age_width)" "$(dashes $url_width)"
fi

IFS=$'\n'

#url escape chars
url_start=$'\e]8;;'
url_sep=$'\e\\'
url_end=$'\e]8;;\e\\'

for branch_data in "${branches_data[@]}"; do
  IFS='@' read -r sha branch age <<<"$branch_data"
  link=""
  if [ "$branch" != "$main_branch" ]; then
    # Get branch description
    description=$(git config branch."$branch".description | sed 's/\n/\n/g') # Make sure actual newlines are present

    # Count commits ahead and behind
    ahead_behind=$(count_commits "$sha" "$main_branch")
    ahead=$(echo "$ahead_behind" | cut -f2)
    behind=$(echo "$ahead_behind" | cut -f1)

    info_format="${GREEN}%-${ahead_width}s ${RED}%-${behind_width}s ${BLUE}%-${max_branch_width}s ${YELLOW}%-${max_age_width}s"
    readarray -t pr_info < <(gh pr view --json url,number,state --jq '.url, .number, .state' $branch 2>/dev/null)
    if [ -n "${pr_info[0]}" ]; then
      case "${pr_info[2]}" in
        'MERGED')
          info_format+=" ${PURPLE}%-${url_width}s" ;;
        'OPEN')
          info_format+=" ${GREEN}%-${url_width}s" ;;
        *)
          # Catch 'CLOSED' and anything else
          info_format+=" ${RED}%-${url_width}s" ;;
      esac
      link+="#${url_start}${pr_info[0]}${url_sep}${pr_info[1]}${url_end}"
    else
      info_format+=" ${NO_COLOR}%-${url_width}s"
    fi

    if [ -n "$description" ]; then
      # Read description into an array by lines
      IFS=$'\n' read -d '' -ra description_lines <<<"$description"

      # Print the first line with proper formatting
      info_format+=" ${NO_COLOR}%-${max_desc_width}s"
      printf "$info_format\n" "$ahead" "$behind" "$branch" "$age" "$link" "${description_lines[0]}"

      # Handle additional lines if they exist
      if [ "${#description_lines[@]}" -gt 1 ]; then
        indent=$((ahead_width + behind_width + max_branch_width + max_age_width + url_width + 5)) # 5 spaces for each color code
        description_indent=$((indent - 1))                                                        # One less since we don't want to count the first space

        # Loop through the remaining lines and print them with indentation
        for i in "${!description_lines[@]}"; do
          if [ $i -ne 0 ]; then # Skip first line, as it is already printed
            printf "%${description_indent}s %s\n" " " "${description_lines[i]}"
          fi
        done
      fi
    else
      printf "$info_format\n" "$ahead" "$behind" "$branch" "$age" "$link"
    fi
  fi
done
