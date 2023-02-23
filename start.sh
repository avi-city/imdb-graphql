docker-compose -d up
mkdir -p data
cd data
wget https://datasets.imdbws.com/name.basics.tsv.gz
wget https://datasets.imdbws.com/title.akas.tsv.gz
wget https://datasets.imdbws.com/title.basics.tsv.gz
wget https://datasets.imdbws.com/title.crew.tsv.gz
wget https://datasets.imdbws.com/title.episode.tsv.gz
wget https://datasets.imdbws.com/title.principals.tsv.gz
wget https://datasets.imdbws.com/title.ratings.tsv.gz
cd ..
psql --host=127.0.0.1 --port=5432 --username=postgres -f imdb-graphql/src/postgres/create_tables.sql
psql --host=127.0.0.1 --port=5432 --username=postgres -f imdb-graphql/src/postgres/load_tables.sql -v data_dir=data
psql --host=127.0.0.1 --port=5432 --username=postgres -f imdb-graphql/src/postgres/format_tables.sql
psql --host=127.0.0.1 --port=5432 --username=postgres -f imdb-graphql/src/postgres/text_search.sql
