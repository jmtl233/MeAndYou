#!/bin/bash
cd /www/wwwroot/www.jmlt.fun || exit

# 清理未跟踪的文件（可以定制清理规则）
git clean -fd

# 保存当前修改
git stash

# 切换到指定分支
git checkout 服务器端

# 恢复保存的修改
git stash pop

# 检查是否有冲突
if git diff --quiet; then
	    echo "没有冲突，继续提交。"
    else
	        echo "检测到合并冲突，请手动解决冲突。"
		    exit 1
fi

# 添加所有更改
git add -A

# 提交并动态生成提交信息
git commit -m "更新于 $(date '+%Y-%m-%d %H:%M:%S')"

# 强制推送到远程分支
echo "警告：此操作将强制推送到远程分支，请谨慎操作！"
git push origin 同步 --force

