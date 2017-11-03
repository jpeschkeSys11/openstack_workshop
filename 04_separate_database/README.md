## scaled setup

In this tutorial we will show how you can scale out your setups. As an example we assume, that we want to run our database service on a dedicated host.

### Server Groups

In this example we organise our servers in some other way than before: We use resource groups to organise our servers. This is not necessary at this point, but will pay off later. One advantage already at this point is, that we can structure our code in different .YAML files (one for each kind of server).

### Preparing scaleout: consul

If we leave the world of single server setups it is nice, to have any kind of service discovery running. With that you won't need any hard coded ip adresses, instead you can just look up service names.
In this example we use consul for that purpose.

### Demilitarized zone

For the first time we create a virtual machine that is not reachable from the outside. For that reason we need to enable AgentForwarding to be able to jump from one host ("publish0") to the other ("author0").

```

openstack server ssh publish0 -l workshop --option "ForwardAgent=yes"


```





