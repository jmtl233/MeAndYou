#!/bin/bash

cd /www/wwwroot/www.jmlt.fun || { echo "无法进入目录！"; exit 1; }

# 清理未跟踪的文件
git clean -fd || { echo "清理未跟踪的文件失败！"; exit 1; }

# 查找并移除所有 .pyc 文件
find . -name "*.pyc" -exec git rm --cached {} \; || { echo "移除 .pyc 文件失败！"; exit 1; }

# 确保移除的文件被添加到暂存区
git add -A || { echo "添加 .pyc 文件移除更改失败！"; exit 1; }

# 提交移除 .pyc 文件的变更
git commit -m "移除 .pyc 文件，避免冲突" || { echo "提交 .pyc 文件移除失败！"; exit 1; }

# 切换到指定分支
git checkout 服务器端 || { echo "切换到服务器端分支失败！"; exit 1; }

# 添加所有更改
git add -A || { echo "添加更改失败！"; exit 1; }

# 提交并动态生成提交信息
commit_msg="更新于 $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_msg" || { echo "提交失败！"; exit 1; }

# 强制推送到远程分支
echo "警告：此操作将强制推送到远程分支，请谨慎操作！"
git push origin 同步 --force || { echo "推送失败！"; exit 1; }

echo "推送操作完成！"
