# github-action-push-to-repository

This action pushes the repository from $GITHUB_WORKSPACE.

Inspired by "cpina/github-action-push-to-another-repository" to fit the required functionality.

## Inputs

### `source-directory`

Path from the root of the app repository. Default `"./"`.

### `destination-github-username`

**Required** Username of the destination github repository.

### `destination-repository-name`

**Required** Destination github repository name.

### `destination-target-branch`

Branch on the destination github repository. Default `main`.

### `user-email`

**Required** Commit user email.

### `user-name`

Commit user name. If omitted `destination-github-username` will be used.

### `commit-message`

Message for the commit.

## Example usage
```
uses: Majoneza/github-action-push-to-repository@v1
with:
  destination-github-username: Majoneza
  destination-repository-name: github-action-push-to-repository
  user-email: majoneza@email.com
```
