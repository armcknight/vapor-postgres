# vapor-postgres

A simple Vapor app that works with a PostgreSQL database, deployable on Heroku.

## Requirements

- Xcode 10
- [vapor](https://docs.vapor.codes/3.0/install/macos/)
- [heroku cli](https://devcenter.heroku.com/articles/heroku-cli)
- [PostgreSQL](https://www.postgresql.org)

> Try `brew install vapor/tap/vapor heroku-cli postgres`

## Create from scratch

```sh
vapor new postdb --template=twostraws/vapor-clean
cd postdb
vapor xcode -y

# make Procfile for Heroku
echo "web: Run --env production --hostname 0.0.0.0 --port \$PORT
local: vapor run" > Procfile
```

Follow the HackingWithSwift article, substituting a PostgreSQL database for the SQLite one they use. Used the Medium article to help with that. Then used prior knowledge from http://github.com/armcknight/vapor-hello-world with other searches online to troubleshoot deployment to Heroku.

## Deployment

Before running locally, you must have a Postgres server running with a database ready to use. In the project it is named `vapor_pg_test`. Use these steps:

```sh
# set up database and start postgres server
createdb vapor_pg_test
postgres -D /usr/local/var/postgres/ &
```

### Local

```sh
# start app server
pushd postdb
vapor run & # or run the `Run` scheme in Xcode.
popd

# open browser to app
open http://localhost:8080
```

### Locally with Heroku

```sh
pushd postdb
heroku local local &
open http://localhost:8080
popd
```

### Remote

```sh
# provision heroku app with working vapor buildpack
heroku create --buildpack https://github.com/vapor-community/heroku-buildpack.git # vapor/vapor is supposed to be the stable release but currently doesn't work
heroku stack:set heroku-16 -a <app-name> # the buildpack doesn't work on the current default stack heroku-18, so we must downgrade

# provision a heroku postgresql addon
heroku addons:create heroku-postgresql:hobby-dev

# deploy and browse to app
git subtree push --prefix postdb heroku master # heroku wants everything to be in the root directory, but I don't wanna
heroku open
```

## References

- [Persisting Data with Vapor 3 and PostgreSQL](https://medium.com/flatiron-labs/persisting-data-with-vapor-3-and-postgresql-246386ac1448)
- [Get started with Vapor 3 for free](https://www.hackingwithswift.com/articles/67/get-started-with-vapor-3-for-free)

> Preserved in `docs/`.

# Contribute

Issues and pull requests are welcome! 

If this project helped you, please consider <a href="https://www.paypal.me/armcknight">leaving a tip</a> 🤗

Do you need help with a project? [I'm currently available for hire or contract.](http://tworingsoft.com/contracts).
