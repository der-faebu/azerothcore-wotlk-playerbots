#!/bin/bash

set -e

echo "Adding modules as submodules"

TARGET_DIR="${1:-modules}"

GIT_REPOS=(
  https://github.com/der-faebu/mod-playerbots.git
  https://github.com/azerothcore/mod-ah-bot.git
  https://github.com/azerothcore/mod-aoe-loot.git
  https://github.com/noisiver/mod-assistant.git
  https://github.com/azerothcore/mod-npc-enchanter.git
  https://github.com/azerothcore/mod-random-enchants.git
  https://github.com/ZhengPeiRu21/mod-reagent-bank.git
  https://github.com/azerothcore/mod-solocraft.git
  https://github.com/AnchyDev/DungeonRespawn.git
  https://github.com/azerothcore/mod-transmog.git
  https://github.com/azerothcore/mod-anticheat.git
)

# Ensure the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Creating target directory: $TARGET_DIR"
  mkdir -p "$TARGET_DIR"
fi

cd "$TARGET_DIR"

for repo_url in "${GIT_REPOS[@]}"; do
    repo_name=$(basename "$repo_url" .git)
    repo_path="$TARGET_DIR/$repo_name"

    # Check if the repo is already a submodule
    if git submodule status | grep -q "$repo_name"; then
        echo "Submodule $repo_name already exists. Updating..."
        git submodule update --remote --init --recursive "$repo_name"
    else
        echo "Adding submodule: $repo_name"
        git submodule add --force --depth 1 "$repo_url" "$repo_name"
    fi
done

echo "Updating all submodules to the latest version..."
git submodule update --remote --recursive

echo "All repositories are added as submodules and updated."
