## Accessing the OpenStack API

To access the OpenStack API you need two credentials:

1. A valid pair of username/ password for authentication

2. A way to send valid commands to the API.


### Authentication 

We assume that you got username/ password from your OpenStack provider.
With these informations you are able to get a prepared control file from 
the OpenStack Dashboard (Horizon).

A sample openrc file is stored in this repository, you can replace that file with the one you downloaded from Horizon vi "Compute" --> "Access and Security" --> "API Access" --> "Download OpenStack RC File v3".

### Working environment

To be able to program against the OpenStack API we choose to fire up a pre defined HOT-template which starts a virtual machine with all neccessary client installed.

For that, navigate to "Compute" --> "Access and Security" --> "Key Pairs" and upload a valid SSH-public key using the button "Import Key Pair".
Remember the name you gave to the key, we will use it later.

Now navigate to "Orchestration" --> "Stacks" and klick on "Launch Stack".
In the drop down field "Template" choose "URL" and paste the following URL:

https://raw.githubusercontent.com/syseleven/heattemplates-examples/master/gettingStarted/sysElevenStackKickstart.yaml

Leave any other field untouched and press "Next".

Fill in the desired name for your stack (we will use the name "workstation" during this example). Also fill in the fiel "key_name" with the name you choose earlier for your public SSH key. Then klick "Launch" and you are done.

You can now navigate to "Compute" --> "Overview" and see, that a newly created VM has spawned. Klick on the name of the machine and copy the public ip address to be able to login there via SSH

``` ssh syseleven@<pasteIPHere> ```

You can now copy the previously downloaded OpenRC file to the home directory of the syseleven user.
Now source the OpenRC file:

``` source openrc ```

And test if anything went well:

``` openstack server list ```

This command should bring something up like 

```

syseleven@kickstart:~$ openstack server list
+--------------------------------------+------------------------+--------+-----------------------------------------+
| ID                                   | Name                   | Status | Networks                                |
+--------------------------------------+------------------------+--------+-----------------------------------------+
| 80df4610-c591-41c6-a1a1-75141e700b17 | kickstart              | ACTIVE | kickstart-net=10.0.0.10, 185.56.130.234 |
+--------------------------------------+------------------------+--------+-----------------------------------------+

```







