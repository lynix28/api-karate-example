/* eslint-disable no-unused-vars */
function checkIsEmptyValue(value, condition) {
	if (condition == 'empty') return '';
	if (condition == 'non-empty') return value;
}