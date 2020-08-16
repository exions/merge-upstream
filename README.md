# Merge Upstream
Merge changes from an upstream repository branch into a current repository branch. For example, updating changes from the repository that was forked from.

Current limitations:
- only merge only selected branch
- branch has to be of the same name
- only work with public upstream Github repository

## Usage

### Set up for manual trigger
copy and commit this to `.github/workflows/merge-upstream.yml` in your default branch of your repository.

```yaml
name: Manual Merge Remote Action
on: 
  workflow_dispatch:
    inputs:
      upstream:
        description: 'Upstream repository owner/name. Eg. exions/merge-upstream'
        required: true
        default: 'owner/name'       # set the upstream repo
      branch:
        description: 'Branch to merge'
        required: true
        default: 'master'           # set the branch to merge

jobs:
  merge-upstream:
    runs-on: ubuntu-latest
    steps: 
      - name: Checkout
        uses: actions/checkout@v2
        with:
          ref: ${{ github.event.inputs.branch }}
          fetch-depth: 0 
      - name: Merge Upstream
        uses: exions/merge-upstream@v1
        with:
          upstream: ${{ github.event.inputs.upstream }}
          branch: ${{ github.event.inputs.branch }}
```

### Set up for scheduled trigger

```yaml
name: Scheduled Merge Remote Action
on: 
  schedule:
    - cron: '0 0 * * 1'
    # scheduled for 00:00 every Monday

jobs:
  merge-upstream:
    runs-on: ubuntu-latest
    steps: 
      - name: Checkout
        uses: actions/checkout@v2
        with:
          ref: ${{ github.event.inputs.branch }}
          fetch-depth: 0 
      - name: Merge Upstream
        uses: exions/merge-upstream@v1
        with:
          upstream: owner/repo    # set the upstream repo
          branch: master          # set the branch to merge
```

Reference: 
- [Triggering a workflow with events](https://docs.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow#triggering-a-workflow-with-events)

## How to run this action manually

This action can trigger manually as needed. 

1. Go to `Actions` at the top of your Github repository
2. Click on `Manual Undo Push Action` (or other name you have given) under `All workflows`
3. You will see `Run workflow`, click on it
4. Fill in the branch to undo the most recent push (⚠️ make sure it is correct)
5. Click `Run workflow`
6. Check your branch commit history
