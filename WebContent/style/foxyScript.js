function toggleBox(szDivID, iState) { // 1 visible, 0 hidden 
	if(document.layers)    //NN4+
      {
		document.layers[szDivID].visibility = iState ? "show" : "hide";
	}
	else if(document.getElementById)   //gecko(NN6) + IE 5+
	{
		var obj = document.getElementById(szDivID);
		obj.style.visibility = iState ? "visible" : "hidden";
	}
	else if(document.all)        // IE 4
	{
		document.all[szDivID].style.visibility = iState ? "visible" : "hidden";
	}
}

function foxyHide(uiId) {
    toggleBox(uiId, 0);
}

function foxyShow(uiId) {
    toggleBox(uiId, 1);
}