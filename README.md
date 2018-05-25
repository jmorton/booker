# BOOKER

This app demonstrates a very simple reservation REST API implemented with Rails.

## Database

This app uses PostgreSQL features to enforce data integrity.

```
pg_ctl init -D db/dev
postgres -D db/dev
```

## Tests

Run tests with:

```
rake cucumber
```
