## Requirements

The distributed version of FFMEPG might not enable x11-grab. 

## Steps

You must compile it yourself, a possiblity is to compile the javacpp-preset for ffpmeg yourself. 

Clone the repo from : https://github.com/bytedeco/javacpp-presets

``` bash
cd javacpp-presets
cd ffmpeg
sh cppbuild.sh install
mvn install 
```

The compiled library will be in `javacpp-presets/ffmpeg/target` folder. Copy all the `.jar` file and replace them in `~/sketchbook/libraries/javacpp/library`. 
