**TODO** expliquer la diff entre imageExtractionProcessingRendering et SeeThrough rendering

CameraTest va dans Calibration, au lieu des exemples.

#Camera
##Image Tracking
- [ExtractPlanarObjectForTracking](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ExtractPlanarObjectForTracking) : utilitaire - photos de zones arbitraires pour tracking d'image
- [FindPlanarObjectLocation](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/FindPlanarObjectLocation) : position manuelle des marqueurs (4 marqueurs en postés à des coins déifinissant une taille commune)
- [GuiCorners](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/GuiCorners) : exemple d'interface avec angles draggables définissant la position manuelle des marqueurs
- [ImageBasedTracking](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ImageBasedTracking) : utilisation de tracking basé Image (et pas marqueur) **non fonctionnel**

##3D Positions
- [LoadExternalLocation](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/LoadExternalLocation) : permet de charger une position 3D préalablement sauvegardée
- [RelativeLocations](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/RelativeLocations) : deux rendus avec des éléments qui vont d'une feuille à l'autre. 
- [SaveLocation](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SaveLocation) : sauvegarde et chargement d'une position 3D de feuille (le fichier est sauvegardé dans le dossier  SavedLocations)

##Quality and rendering
- [RenderingQuality](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/RenderingQuality) : rendu des différentes tailles : qualité de projection (DrawAroundPaper), de feuille en fonction de la qualité en pixels/mm (DrawOnPaper)
- [SeeThroughGUI](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SeeThroughGUI) : interface GUI (Graphical User Interface)
- [SeeThroughOnePaper](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SeeThroughOnePaper) : 1 feuille, 1 affichage - l'application PapART la plus simple qu'il soit.
 - application : [SolarSystem](https://github.com/potioc/Papart-examples/tree/master/apps/SolarSystem) (3 feuilles, 1 objet/feuille)
- [SeeThroughWith3DObject](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SeeThroughWith3DObject) : deux **types** de rendus, 2 feuilles = 1 PaperScreen en **DrawAroundPaper** + 1 PaperScreen en **DrawOnPaper**

##Image Analysis Examples
- [ColorDetectionExample](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ColorDetectionExample) : analyse de petites zones - détection de couleurs / formes
- [ImageExtractionProcessingRendering](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ImageExtractionProcessingRendering) : Processing -- extraction de zone : 1 feuille avec 1 zone de capture 
- [ImageExtractionSeeThroughRendering](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ImageExtractionSeeThroughRendering) : See Through -- extraction de zone : 1 feuille avec 1 zone de capture
- [StrokeDetection](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/StrokeDetection) analyse de grandes zones : dessins
 - application : [jeuTech](https://github.com/potioc/Papart-examples/tree/master/apps/jeuTech) (utilise les outils d'analyse d'image ci-dessus)


#Intégration d'autres bibliothèques 
Intégré :
- Leap motion  [LeapMotionExample](https://github.com/potioc/Papart-examples/tree/master/apps/LeapMotionExample)

A réaliser :
- optitrack + Detection de texte
- Graphophone
- programme de calibration de caméra. 
