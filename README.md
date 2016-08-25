Introduction
============

A Docker container which will run the [Netdisco
II](http://search.cpan.org/dist/App-Netdisco/lib/App/Netdisco.pm) daemon and
associated web interface.


[![](https://images.microbadger.com/badges/image/irasnyd/netdisco.svg)](https://microbadger.com/images/irasnyd/netdisco "Get your own image badge on microbadger.com")

The container slightly modifies the the Netdisco source code to make it able to
run without downloading files from the Internet. This makes it start much more
quickly.

Quickstart Instructions
=======================

- Use the included `docker-compose.yml` to start the database and netdisco containers.
- Navigate to <http://localhost:5000/> in your web browser.
- Log in and discover your first SNMP enabled network device.

Environment Variables
=====================

Database parameters
-------------------

- `NETDISCO_DB_NAME` - The database name (default: "netdisco")
- `NETDISCO_DB_USER` - The database user (default: `$DB_ENV_POSTGRES_USER`, fallback to "netdisco")
- `NETDISCO_DB_PASS` - The database user (default: `$DB_ENV_POSTGRES_PASSWORD`, fallback to "netdisco")
- `NETDISCO_DB_HOST` - The database host (default: `$DB_PORT_5432_TCP_ADDR`, fallback to "postgres.example.com")
- `NETDISCO_DB_PORT` - The database port (default: `$DB_PORT_5432_TCP_PORT`, fallback to "5432")
- `NETDISCO_DB_ROLE` - The database role (default: "netdisco")

SNMP parameters
---------------

- `NETDISCO_RO_COMMUNITY` - The SNMP community for read only access (default: "public")
- `NETDISCO_WR_COMMUNITY` - The SNMP community for read write access (default: "")

Netdisco parameters
-------------------

- `NETDISCO_ADMIN_USER` - The Netdisco Administrator username (default: "netdisco")
- `NETDISCO_ADMIN_PASS` - The Netdisco Administrator password (default: "netdisco")
- `NETDISCO_DOMAIN` - The Netdisco domain name (default: output of `hostname -d`)

Credits
=======

The Docker entrypoint is heavily inspired by:

- <https://github.com/sheeprine/docker-netdisco>
