# GitHub Actions Collection

This repository contains a collection of reusable GitHub Actions.

## Actions

### Deploy dist to Surge (`deploy-dist-to-surge`)

Deploys a distribution folder (typically `dist/`) to Surge.sh.

#### Inputs

| 名称          | 描述                                                                                                     | 是否必须 | 默认值 |
|---------------|-----------------------------------------------------------------------------------------------------------------|----------|---------|
| `working_dir` | 执行 Surge 部署的工作目录。默认为仓库根目录。                                                                       | `false`  | `.`     |
| `dist_dir`    | 包含要部署的构建产物的目录。如果指定了 `working_dir`，则相对于 `working_dir`，否则相对于仓库根目录。                                     | `false`  | `dist`  |
| `domain_suffix` | 部署时用于创建唯一域名的后缀（例如，用于在同一工作流程中测试多个实例）。最终域名将是 `<sha><suffix>.surge.sh`。                                   | `false`  | `''`    |
| `surge_token` | **已弃用.** 用于部署的 Surge 令牌。建议在工作流程中将其设置为环境变量 `SURGE_TOKEN`。                                                        | `false`  | (从 `SURGE_TOKEN` 环境变量读取，如果未设置则使用硬编码令牌) |


#### Outputs

| Name  | Description      |
|-------|------------------|
| `url` | The Preview URL. |

#### Example Usage

```yaml
name: Deploy to Surge

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      # Assuming your build process outputs to 'build_output' inside 'frontend' directory
      - name: Build application
        run: |
          cd frontend
          npm install
          npm run build
      - name: Deploy to Surge
        uses: YOUR_USERNAME/YOUR_REPONAME/deploy-dist-to-surge@main # Replace with your actual repo path
        with:
          working_dir: frontend
          dist_dir: build_output
        env:
          SURGE_TOKEN: ${{ secrets.SURGE_TOKEN }} # Recommended way to provide the token
```

### Other Actions

- **`docker-build-push`**: Builds and pushes Docker images.
- **`npm-build-fix-to-nexus`**: Builds and fixes NPM packages for Nexus.
- **`setup-node-environment`**: Sets up a Node.js environment.
- **`upload-to-alist`**: Uploads files to Alist.

---
*Original reference note (can be removed or integrated elsewhere):*
- https://github.com/renovatebot/renovate/blob/81fc75630b0b43fb4b89a0b65c1086d487e65d2e/.github/actions/setup-node/action.yml
