#!/bin/bash

# 进入项目目录，如果失败则退出
cd /www/wwwroot/www.jmlt.fun || exit

# 定义需要匹配的分支名称前缀
branch_prefix="备份"

# 获取当前时间，用于日志记录
current_time=$(date '+%Y年%m月%d日 %H时%M分%S秒')

# 删除旧的本地备份分支
echo "[$current_time] 正在清理本地备份分支..."
local_branches=$(git branch --list "$branch_prefix*" --format='%(refname:short)' | sort -r | tail -n +3)
if [ -n "$local_branches" ]; then
  echo "以下本地备份分支将被删除："
  echo "$local_branches"
  echo "$local_branches" | xargs git branch -D
else
  echo "没有需要删除的本地备份分支。"
fi

# 删除旧的远程备份分支
echo "[$current_time] 正在清理远程备份分支..."
remote_branches=$(git branch -r --list "origin/$branch_prefix*" --format='%(refname:short)' | sort -r | tail -n +3)
if [ -n "$remote_branches" ]; then
  echo "以下远程备份分支将被删除："
  echo "$remote_branches"
  echo "$remote_branches" | sed 's/origin\///' | xargs -I {} git push origin --delete {}
else
  echo "没有需要删除的远程备份分支。"
fi

echo "[$current_time] 旧的备份分支已清理，保留最新的两个分支。"