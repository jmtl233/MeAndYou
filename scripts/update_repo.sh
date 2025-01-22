#!/bin/bash
cd /www/wwwroot/www.jmlt.fun || exit

# 清理未跟踪的文件（可以定制清理规则）
git clean -fd

# 保存当前修改
git stash

# 切换到服务器端分支
git checkout 服务器端 || exit

# 获取当前时间，格式为 "自动同步-YYYY年MM月DD日-HH时MM分SS秒"
branch_name="自动同步-$(date '+%Y年%m月%d日-%H时%M分%S秒')"

# 创建但不切换到新分支
git branch "$branch_name" || exit

# 恢复保存的修改
git stash pop

# 添加所有更改
git add -A

# 提交并动态生成提交信息
git commit -m "更新于 $(date '+%Y年%m月%d日 %H时%M分%S秒')"

# 强制推送到远程分支
echo "警告：此操作将强制推送到远程分支，请谨慎操作！"
git push origin "$branch_name" --force
