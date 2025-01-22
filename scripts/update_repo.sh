#!/bin/bash

# 切换到项目目录
cd /www/wwwroot/www.jmlt.fun || { echo "无法进入目录！"; exit 1; }

# 清理未跟踪的文件
git clean -fd || { echo "清理未跟踪的文件失败！"; exit 1; }

# 保存当前修改
git stash || { echo "保存当前修改失败！"; exit 1; }

# 切换到指定分支
git checkout 服务器端 || { echo "切换到服务器端分支失败！"; exit 1; }

# 恢复保存的修改
git stash pop || { echo "恢复保存的修改失败！"; exit 1; }

# 检查是否有冲突
if ! git diff --quiet; then
    echo "检测到合并冲突，请手动解决冲突。"
    exit 1
fi

# 添加所有更改
git add -A || { echo "添加更改失败！"; exit 1; }

# 提交并动态生成提交信息
commit_msg="更新于 $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_msg" || { echo "提交失败！"; exit 1; }

# 强制推送到远程分支
echo "警告：此操作将强制推送到远程分支，请谨慎操作！"
git push origin 同步 --force || { echo "推送失败！"; exit 1; }

echo "推送操作完成！"
