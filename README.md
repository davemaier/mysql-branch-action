# MySQL branch action

This action clones a template database into a new database which uses a supplied prefix and the branch name as its name. This way it is possible to create isolated test databases for each feature branch. 
The most common usecase for this action is, if a remote database is used for development.

If a new database is created for each pull request, its easy to test database migrations and experiment with the dataset without affecting other developers. If the test data becomes quirky this action can just be re-run and the dataset is clean again. 

Tip: If you use your staging database as template, keep your staging database in sync with your staging branch and populated with meaningful test data, you always have a consistent dataset when branching feature branches from the staging branch. 

## Inputs

### `template-db`

**Required** The name of the database to clone from.

## Example usage

### ToDo