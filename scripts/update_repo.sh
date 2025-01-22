#!/bin/bash
cd /www/wwwroot/www.jmlt.fun || exit

# 清理未跟踪的文件
git clean -fd

# 保存当前修改
git stash

# 切换到指定分支
git checkout 服务器端

# 恢复保存的修改
git stash pop

# 添加所有更改
git add -A

# 提交并动态生成提交信息
git commit -m "更新于 $(date '+%Y-%m-%d %H:%M:%S')"

# 强制推送到远程分支
git push origin 同步 --force

