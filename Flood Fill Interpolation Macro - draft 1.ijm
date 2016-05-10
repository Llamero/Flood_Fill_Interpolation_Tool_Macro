//lineWidth = getNumber("Please enter desired line width", 5);
//run("Line Width...", "line=" + lineWidth);
for(pSlice=1; pSlice <= nSlices; pSlice++) {
	
	//Keep prompting for a point, until a point is drawn.
	selectionCheck = -1;
	while(selectionCheck != 10) {
		//Clear selection after drawing reference line
		run("Select None");
			
		//Make a line
		setTool("point");

		//Wait for user to draw reference lines
		waitForUser("Make selection", "Please make reference line past slice " + pSlice - 1 + ".");
		selectionCheck = selectionType(); 
	}

	getSelectionBounds(x, y, h, w);
	
	//Flood fill at point 
	floodFill(x,y);
	
	currentSlice = getSliceNumber();

	//Clear selection after drawing reference line
	run("Select None");

	//If this is not the first line, then interpoalte from previous line
	if (pSlice!=1){
		//Calculate number to slices between lines
		zDist = currentSlice - pSlice;

		//Calculate x and y distances for line
		dx = x-px;
		dy = y-py;

		//Interpolate and draw in-between lines
		for (a = pSlice; a <= currentSlice; a++){
			//move to next slice
			setSlice(a);

			//Calculate start and end coordinates for next line
			cx = round(px + dx * (a - pSlice) / zDist);
			cy = round(py + dy * (a - pSlice) / zDist);

			//Flood fill at interpolated points
			floodFill(cx,cy);
			
			
		}
	}

	//Set the current line coordinates and slice number as the previous line coordinates for the next loop
	px = x;
	py = y;
	pSlice = getSliceNumber();
}

