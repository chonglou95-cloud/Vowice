#!/bin/bash
# Vowice 一键推送脚本
# 用法：bash ~/Desktop/实习/03_Vowice\:声契\ _一段存在于声音里的记忆/push-to-github.sh

set -e

REPO="$HOME/Desktop/实习/03_Vowice:声契 _一段存在于声音里的记忆"

cd "$REPO"

git pull --rebase origin main 2>/dev/null || git pull origin main

git add -A

if git diff --cached --quiet; then
  echo "没有新变更，已是最新版本。"
  exit 0
fi

TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
git commit -m "更新 $TIMESTAMP"
git push origin main

echo ""
echo "✓ 已推送到 GitHub！"
