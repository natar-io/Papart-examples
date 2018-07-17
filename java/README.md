# Papart Application example

This example shows how to create Papart/Processing application compiled with Maven. 

Run the example:
``` bash
cd example
mvn compile
mvn exec:java -Dexec.mainClass="tech.lity.rea.exemple.SeeThrough"
``` 


## Requirements. 

You need to the the environment varible `SKETCHBOOK` to your sketchbook folder, so that PapARt can load the configuration files and markers. 
You need to install OpenNI if you use the OpenNI cameras. 

## Deploy on a distant machine 

#### Maven deploy 

Run the distant example:
``` bash
cd exampleDeploy
mvn compile
``` 

The launch is quite slow for now, any help for that would be great. 

#### Netbeans deploy

Load the projet `exampleDeployNetbeans` in Netbeans and [deploy on network](exampleDeployNetbeans). 
