#!/bin/bash

# 设置变量
OWNER="yanhao98"
REPO="gemini-balance"
PACKAGE_NAME="gemini-balance"

# 重新登录 GitHub CLI 获取更多权限
echo "正在更新 GitHub CLI 权限..."
gh auth refresh -h github.com -s read:packages,delete:packages

# 列出所有版本的容器镜像
echo "正在获取 $PACKAGE_NAME 所有版本..."
VERSIONS=$(gh api \
  "/user/packages/container/$PACKAGE_NAME/versions" \
  --paginate \
  --jq '.[].id')

# 检查是否有版本存在
if [ -z "$VERSIONS" ]; then
  echo "没有找到 $PACKAGE_NAME 的任何版本"
  exit 0
fi

# 删除每个版本
echo "开始删除 $PACKAGE_NAME 的所有版本..."
for version_id in $VERSIONS; do
  echo "正在删除版本 ID: $version_id"
  gh api \
    --method DELETE \
    "/user/packages/container/$PACKAGE_NAME/versions/$version_id"
  echo "版本 $version_id 已删除"
done

echo "所有 $PACKAGE_NAME 容器镜像版本已成功删除"