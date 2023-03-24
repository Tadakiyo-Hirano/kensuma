require("./fieldworkers");
//= require rails-ujs
function checkFieldValues() {
  const firstField = document.getElementById('first_field');
  const secondField = document.getElementById('second_field');

  // どちらかのフィールドが空の場合、処理を中断
  if (firstField.value === '' || secondField.value === '') {
    return;
  }
  const firstFieldValue = Date.parse(firstField.value);
  const secondFieldValue = Date.parse(secondField.value);
  const differenceInMs = secondFieldValue - firstFieldValue;
  const differenceInYears = differenceInMs / (1000 * 60 * 60 * 24 * 365);
  if (differenceInYears >= 65 || differenceInYears < 18) {
    document.getElementById('required_field').required = true;
  } else {
    document.getElementById('required_field').required = false;
  }
}
document.addEventListener("DOMContentLoaded", function() {
  const firstField = document.getElementById('first_field');
  const secondField = document.getElementById('second_field');

  if (firstField && secondField) {
    firstField.addEventListener('blur', checkFieldValues);
    secondField.addEventListener('blur', checkFieldValues);
  }
  console.log("BB")
});