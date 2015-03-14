 This is the GUI designed for two tracking algorithms: Meanshift tracking and feature-based  tracking.
The GUI now only support 176x144 qcif video sequences. 

Author: Taoran Lu (lvtaoran@ufl.edu)
Department of Electrical and Computer Engineering,
University of Florida
Nov.2007

Main code:
	trackingGUI.m
	trackingGUI.fig


Code for meanshift tracking:
	camshift4gui.m
	select.m
	meanshift.m
Courtesy of:  Adam Kukucka,  Zach Clay, Marcelo Molina  

Code for feature-based t racking:
	feature4gui.m
	LocalMax.m
	DownSample.m
	ComputeQuality.m
	GridQuality.m
	SelectFeature.m
	TKTrack.m
Courtesy of: Hailin Jin and Paolo Favaro