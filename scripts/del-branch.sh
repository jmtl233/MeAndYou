#!/bin/bash
# 切换到目标仓库目录
cd /www/wwwroot/www.jmlt.fun || exit

# 列出所有包含 "自动同步" 的本地分支，按时间逆序排序，保留最新的两个，删除其余的
local_branches=$(git branch | grep '自动同步' | sort -r | tail -n +3)
if [ -n "$local_branches" ]; then
  echo "删除本地旧的自动同步分支："
  echo "$local_branches"
  echo "$local_branches" | xargs git branch -D
else
  echo "没有找到需要删除的本地分支。"
fi

# 列出所有包含 "自动同步" 的远程分支，按时间逆序排序，保留最新的两个，删除其余的
remote_branches=$(git branch -r | grep 'origin/自动同步' | sort -r | tail -n +3)
if [ -n "$remote_branches" ]; then
  echo "删除远程旧的自动同步分支："
  echo "$remote_branches"
  echo "$remote_branches" | sed 's/origin\///' | xargs -I {} git push origin --delete {}
else
  echo "没有找到需要删除的远程分支。"
fi

# 输出提示信息
echo "旧的自动同步分支已删除，保留最新的两个分支。"
