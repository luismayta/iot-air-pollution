Support
#######


How to set Ansible and Terraform files before to deploy a store
===============================================================


Terraform
---------

Here the configuration of the variables.tf file will be done, for which
we have to generate a public and private key with the command for the store:

.. code:: bash

    $ make make.generate store={{name_store}}

And place the private key in "aws_key_path" and the public key in
"key_public"

In "aws_alb_priority" within the variable.tf file, it has to be listed according
to the excel called Access in the "AWS ALB" sheet (This file is located inside
the luismayta drive), Then we proceed to generate the server's terraform-iot-air-pollution by executing
the following codes:

Activate the Terraform modules with terragrunt.init:

.. code:: bash

    $ make terragrunt.init store={{name_store}}


Then execute terragrunt.apply, but first we're going to execute terragrunt.plan
to be able to visualize what will happen if terragrunt.apply is executed:

.. code:: bash

    $ make terragrunt.plan store={{name_store}}

Then:

.. code:: bash

    $ make terragrunt.apply store={{name_store}}


After executing the terragrunt.apply command, it will provide us with a series of data
that will be introduced in ansible files.


Ansible
-------

Among these data is the public and private ip of the server, which will be
entered in the host file within inventoriees / aws, also the "aws_custom_domain"
which will be introduced in the vars.yaml file inside the vars file.

Also you must configure redis cache and redis session taking into account the Excel Access
Cache sheet and finally place the "mixpanel_project_token" (which will be provided by cesar)
these last ones inside the file vars.yaml.

In the end, This command must be executed:

.. code:: bash

    $ make ansible.tag tags=provision,databases,deploy store={{name_store}}



=====================
How we delete a store
=====================

Steps:

* First:

  Make a buckup (review TROUBLESHOOTING.rst)

* Second:

  Execute terragrunt.destroy

  .. code:: bash

    $ make terragrunt.destroy store={{store_name}}