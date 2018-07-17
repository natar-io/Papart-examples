### Deployment as a Netbeans Project. 

## How to use: 

Open the projet in Netbeans and follow the runtime guide for raspberry pi:
https://blog.idrsolutions.com/2014/08/using-netbeans-remotely-deploy-projects-raspberry-pi/

### Deployment changes: 

On the distant machine you must have `sshd` installed, and active. 
In `/etc/ssh/sshd_config` you must uncomment and enable `PermitUserEnvironment yes`. 

Once it is done, you can set  `~/.ssh/environment` to : 

``` bash 
DISPLAY=:0.0
SKETCHBOOK=$HOME/sketchbook
```