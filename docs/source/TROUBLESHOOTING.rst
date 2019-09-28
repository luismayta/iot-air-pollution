Troubleshooting
###############

Postgresql
==========

Correlative pk
--------------

Fix: error id correlative in table
it in your database, run ::

  select setval('{table}_id_seq', (select max(id) from {table}));

Wrong pre-commit with pyenv
---------------------------

Fix: When you've deleted all orders and you want to reset id
it in your database, run ::

    select setval(pg_get_serial_sequence('order','id'), coalesce(max("id"), 1), max("id") IS NOT null) FROM order;


Execute the next:

.. code:: bash

    pyenv install 3.6.4
    pyenv install 3.6.5
    pyenv install 3.6.6
    pyenv shell 3.6.5