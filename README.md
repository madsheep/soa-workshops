# Sample SOA backend with elixir, ruby and php.

- php proxy takes in request
- checks authentication against elixir auth service
- if user and password are fine it takes data from ruby invoices service


## Running

- run `docker-compose up`
- open clients list: http://localhost:8001/clients.php?user=madsheep&password=owca
- open invoices list: http://localhost:8001/invoices.php?user=madsheep&password=owca&client_id=facebook