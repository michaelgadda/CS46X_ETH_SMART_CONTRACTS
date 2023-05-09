const guessInput = document.getElementById("User-input");
const submitButton = document.getElementById("submit-button");
const resultParagraph = document.getElementById("result");

submitButton.addEventListener("click", function() {
  
  const userInput = parseInt(Input.value);

  
 
});

const createLoanButton = document.getElementById("createLoanButton");
const loadingIcon = document.getElementById("loading-icon");

createLoanButton.addEventListener("click", async () => {
  loadingIcon.style.display = "block";

  // Perform your heavy computation or API call here

  loadingIcon.style.display = "none";
});