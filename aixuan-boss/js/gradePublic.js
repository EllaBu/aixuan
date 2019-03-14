	//有责任分的二级分类
	var dutysArr = [];
	dutysArr.push(33);
	dutysArr.push(34);
	dutysArr.push(35);
	dutysArr.push(36);
	dutysArr.push(37);
	dutysArr.push(38);
	dutysArr.push(40);
	dutysArr.push(41);
	dutysArr.push(43);
	dutysArr.push(44);
	dutysArr.push(46);
/*	dutysArr.push(47);
	dutysArr.push(48);
	dutysArr.push(49);*/
	dutysArr.push(51);
	dutysArr.push(54);
	dutysArr.push(55);
	dutysArr.push(59);
	//有病种分的二级分类
	var diseaseArr = [];
	diseaseArr.push(33);
	diseaseArr.push(34);
	diseaseArr.push(35);
	diseaseArr.push(36);
	diseaseArr.push(37);
	diseaseArr.push(38);
	
function isDuty(series_no){
	var duty=false;
	for(var i=0;i<dutysArr.length;i++){
		var dutyId=dutysArr[i];
		if(series_no == dutyId){
			duty = true;
			break;
		}
	}
	return duty;
}

function isDisease(series_no){
	var disease=false;
	for(var i=0;i<diseaseArr.length;i++){
		var diseaseId=diseaseArr[i];
		if(series_no == diseaseId){
			disease = true;
			break;
		}
	}
	return disease;
}