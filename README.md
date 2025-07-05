# GitHub Actions Collection

This repository contains a collection of reusable GitHub Actions.

## Actions

### Deploy dist to Surge (`deploy-dist-to-surge`)

Deploys a distribution folder (typically `dist/`) to Surge.sh.

#### Inputs

| Name          | Description                                                                                                     | Required | Default |
|---------------|-----------------------------------------------------------------------------------------------------------------|----------|---------|
| `working_dir` | The working directory to run the Surge deployment from. Defaults to the repository root.                        | `false`  | `.`     |
| `dist_dir`    | The directory containing the built assets to deploy. Relative to `working_dir` if specified, otherwise relative to repository root. | `false`  | `dist`  |
| `surge_token` | **Deprecated.** The Surge token to use for deployment. It's recommended to set this as an environment variable `SURGE_TOKEN` in your workflow instead. | `false`  | (Reads from `SURGE_TOKEN` env var or uses hardcoded token if not set) |


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
