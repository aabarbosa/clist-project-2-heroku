function passToPpf(array) {
	var doc = {
		content : createStringByFour(array)
	};
	pdfMake.createPdf(doc).download('List_Of_Tasks.pdf');
}

function createStringByFour(data) {
	var result = 'Exported PDF File' + "\n";
	result += "\n" + "    TABLE OF TASKS:    " + "\n";

	for (var i = 0; i < data.length; i += 4) {
		result += "Name:   " + data[i] + "       Description:   " + data[i + 1]
				+ "       Category:   " + data[i + 2] + "       Priority:   "
				+ data[i + 3] + "\n";
	}
	return result;
}
