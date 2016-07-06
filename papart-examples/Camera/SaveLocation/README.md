#Save location - how to keep a 3D position in memory
##Application
This shows how to retain a 3D position of a marker sheet. 

When one press 'S' key, the location in physical space of the marker is saved in the SavedLocations folder. 

`app.saveLocationTo("../SavedLocations/loc.xml");`

Users can also see what position has been saved when pressing 'L' key and moving the marker around: the rectangle stays at the same location.

`app.loadLocationFrom("../SavedLocations/loc.xml");`

Other applications can use the saved positions through the folder.

##Results

![Saving a location](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/SaveLocation/savelocation.png)
