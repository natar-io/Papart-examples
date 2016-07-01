Camera
- 1 feuille, 1 affichage --- PaperApp2D -> [SeeThroughOnePaper](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SeeThroughOnePaper)
- 3 feuilles, 1 affichage :  Solar system Example  -> [SolarSystem](https://github.com/potioc/Papart-examples/tree/master/apps/SolarSystem)

- sauvegarde et chargement d'une position 3D de feuille   -- to update [SaveLocation](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SaveLocation)
- utilisation de sauvegardes inter appli-- --> LoadExternalLocation [LoadExternalLocation](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/LoadExternalLocation)
- utilisation de tracking basé Image (et pas marqueur) -> [ImageBasedTracking](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ImageBasedTracking) **non fonctionnel**

- rendu des différentes tailles : qualité de projetction (DrawAroundPaper), de feuille en fonction de la qualité en pixels/mm (DrawOnPaper)  -> [RenderingQuality](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/RenderingQuality)

- deux types de rendus : 2 feuilles, 1 écran, 1 modèle 3D --- PaperApp3D   --> [SeeThroughWith3DObject](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SeeThroughWith3DObject)

- Deux Rendus avec des éléments qui vont d'une feuille à l'autre. [RelativeLocations](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/RelativeLocations)


- utilitaire : photos de zones arbitraires pour tracking d'image. -- CaptureCustom -> [ExtractPlanarObjectForTracking](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ExtractPlanarObjectForTracking)

- position manuelle des marqueurs (4 marqueurs en postés à des coins déifinissant une taille commune) -- -> [FindPlanarObjectLocation](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/FindPlanarObjectLocation)
- chargement de position manuelle des marqueurs -> [LoadKnownObjectLocation](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/LoadKnownObjectLocation) **à reprendre depuis LoadExternalLocation**

- exemple d'interface avec angles draggables définissant la position manuelle des marqueurs -> [GuiCorners](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/GuiCorners)

### Image Analysis Examples

CameraTest va dans Calibration, au lieu des exemples. 

- Processing -- extraction de zone : 1 feuille avec 1 zone de capture   --- Capture -> [ImageExtractionProcessingRendering](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ImageExtractionProcessingRendering)

- See Through -- extraction de zone : 1 feuille avec 1 zone de capture   --- Capture -> [ImageExtractionSeeThroughRendering](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ImageExtractionSeeThroughRendering)

 - analyse de petites zones : détection de couleurs / formes  --> [ColorDetectionExample](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ColorDetectionExample)

- analyse de grandes zones : dessins  --> [StrokeDetection](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/StrokeDetection)

+ programme de calibration de caméra. 

### Intégration avec autres bibliothèques 
- leap + optitrack + Detection de texte
- Leap motion  [LeapMotionExample](https://github.com/potioc/Papart-examples/tree/master/apps/LeapMotionExample)
- interface GUI (Graphical User Interface)  [SeeThroughGUI](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SeeThroughGUI)
- Graphophone
