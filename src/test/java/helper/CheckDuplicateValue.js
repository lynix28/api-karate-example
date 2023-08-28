/* eslint-disable no-unused-vars */
function checkDuplicate(array) { 
	return (new Set(array)).size !== array.length; 
}