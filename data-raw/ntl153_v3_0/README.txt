The data contained for this lake was digitized from the Wisconsin DNR lake survey maps of depth contours. Survey maps were digitized in ArcGIS and rectified to the Wisconsin Transverse Mercator (WTM) coordinate system by matching lake boundaries to those seen in the Wisconsin Hydro data set. All work described in this readme file was done at the Center for Limnology at the University of Wisconsin-Madison in the 2003-2004 academic year.

The lake directory contains files in the main directory, with several additional subdirectories:

MAIN DIRECTORY: <lakename_lakenumber> (Note: lake number refers to the Wisconsin Water Body Identification Code)

1) Shapefiles: All shapefiles are located in the main directory and are as follows: 
	      (Note: not all lakes have all of these shapefiles)

	'bathy'-- The bathymetric lines from the digitized maps.  Most lakes are measured in feet, but a few are in                   meters.  The depth of each line can be found in the Attributes Table under the ID column.
	'border'-- The outer edge of the lake.
	'contours-all'-- All of the contours of a lake including the bathymetric lines, the border, and the islands.                          The depth for each line can be found in both feet and meters in the Attributes Table.
	'islands'-- The islands in the lake.
	'marsh'-- The marshes in the area around the lake.  Open water within a marsh is indicated with blue.
	'emergent'-- Emergent macrophytes
	'submergent'-- Submergent macrophytes
	'floating'-- Floating macrophytes
	'inlets'-- Inlets to the lake
	'outlets'-- Outlets of the lake
	'inlets-outlets'-- Inlets and outlets of the lake, but it is not specified which is which. 

2) ArcView project file (<lakename_lakenumber>.apr): This ArcView 3.3 project displays several of the datasets described in this document.


SUBDIRECTORIES:

1) GISprojects: Contains the ArcMap project file for the lake (<lakename_lakenumber>.mxd)

2) Grid: Contains three natural-neighbors interpolations of lake depth (measured in meters) at 1, 5, and 30 meter
	 spatial resolutions.  The interpolations were created from the pttheme file in the points subdirectory 
	 (see 5 below).  

3) jpg: Contains JPEG images of the lake which were exported from ArcMap.
	- <lakename>-grid1m : this is a JPEG showing the 1m resolution grid (see 2 above) with a green background
	- <lakename>-grid1m+extras: JPEG showing the 1m grid and the extra shapefiles including: marshes, islands, 
	                            inlets, outlets, and floating, emergent, and submergent macrophytes.
	- <lakename>-grid1m+extras+contours: the same as the above image, but showing the digitized contour lines.
	- <lakename>-map+grid1m+extras+contours: the same as the above image, but showing the DNR lake map as a
						 background.

4) Maps: 
	- Original: Contains the original GIF or JPEG image of the map
	- Processed:
		- IMG: Contains the image analysis map that has been rectified to the WTM.
		- Tif: Contains the Tif image of the map that can be loaded into ArcView, and which was used to
		       make the IMG map.

5) Points: Contains the zipped pointthemeexport file.  It is the exported interchange file of the pttheme point            shapefile, from which the interpolated grids were made.  It can be used in ArcMap by unzipping and            importing it with ArcToolbox.
           ArcToolbox --> Conversion Tools --> Import to Coverage --> Import from Interchange file.



Major technical steps included:

1) Digitizing lake bathymetry:
   Contour lines were digitized by tracing the bathymetric lines of the lake map to create polygons.  Together,    these polygons made up the ‘bathy’ shapefile. This method was also used to digitize the border, marshes, etc.  

2) Creation of contours-all shapefile:
   This shapefile was created by merging the bathy, border, and islands shapefiles into a single shapefile.

3) Creation of pttheme points shapefile:
   The contours-all shapefile was converted to a point shape file through several steps:  
   Contours-all --> shapearc file --> linegrid file --> gridpoint file called pttheme.  
   This resulted in a theme of points, where each point had the value of one of the bathymetric contours.  In          essence, this turned the contour lines into “lines” made up of points, which can be used for interpolations.

4) Interpolation:
   The "Natural neighbors" interpolation algorithm in ArcMap was used to interpolate smooth gradients between the       assembled points of pttheme. 


###END###
