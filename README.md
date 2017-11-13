# Sample SOA backend with elixir, ruby and php.

- php proxy takes in request
- checks authentication against elixir auth service
- if user and password are fine it takes data from ruby invoices service


## Running

- run `docker-compose up`
- open clients list: http://localhost:8001/clients.php?user=madsheep&password=owca
- open invoices list: http://localhost:8001/invoices.php?user=madsheep&password=owca&client_id=facebook


## Backend queues

Backend provides few rabbitmq rpc queues that can be queried if needed

- backend.auth - checks authentication
- backend.clients - gives back clients list
- backend.invoices - gives back invoices list for given 'client_id'

You can test the queues with attached `mq-client` script like so:


```
> docker-compose up -d
Starting workshop_rabbitmq_1 ...
Starting workshop_rabbitmq_1 ... done
Starting workshop_ruby-invoices_1 ...
Starting workshop_ruby-invoices_1
Starting workshop_elixir-auth_1 ...
Starting workshop_elixir-auth_1
Starting workshop_php-proxy_1 ...
Starting workshop_ruby-invoices_1 ... done

> ./mq-client backend.clients
{"clients":["google","facebook","yahoo","twitter"]}

> ./mq-client backend.auth '{"user":"madsheep", "password":"owca"}'
{"login":true}
```