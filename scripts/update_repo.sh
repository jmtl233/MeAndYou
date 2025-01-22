#!/bin/bash

# 定义目标分支
TARGET_BRANCH="服务器端"

# 切换到项目目录
cd /www/wwwroot/www.jmlt.fun || { echo "无法进入目录！"; exit 1; }

# 强制清理工作区，丢弃未提交的更改
echo "强制清理工作区..."
git reset --hard || { echo "重置工作区失败！"; exit 1; }

# 清理未跟踪的文件
git clean -fd || { echo "清理未跟踪的文件失败！"; exit 1; }

# 强制切换到目标分支
echo "强制切换到分支 $TARGET_BRANCH..."
git checkout -f "$TARGET_BRANCH" || { echo "切换到分支 $TARGET_BRANCH 失败！"; exit 1; }

# 添加所有更改
git add -A || { echo "添加更改失败！"; exit 1; }

# 提交并动态生成提交信息
commit_msg="更新于 $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_msg" || { echo "提交失败！"; exit 1; }

# 强制推送到远程分支
echo "警告：此操作将强制推送到远程分支，请谨慎操作！"
git push origin 同步 --force || { echo "推送失败！"; exit 1; }

echo "推送操作完成！"
