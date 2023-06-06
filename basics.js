// MDN (Mozilla Developer Network) is a good source for JS.
function changeMessages(message, discountRate) {
    document.getElementById('message').textContent = message;  // this is a DOM element
    document.getElementById("discount").textContent = discountRate;  // (Document Object Model)
}
// another fnc declaration method: let changeMessages = function() { }

let titleText = "Get a grip!",  // Unlike Python, variable names are written as camelCase.
    discount = 40,
    discountRate = "0.123abc"
    productName = "Hiking Boots",
    productRemovalYear = 2025;

discountRate = Number.parseFloat(discountRate)  // Variable updated.
var discountAvailable = !true  // 'var' is not used anymore because
// It has bugs. Its variable defined in a block still lives outside.
// Also, doesn't throw errors when defined wrongly etc.
let productId;  // undefined
productId = 612
productId = null  // value is wiped.
productId = undefined // undefined

const yearSold = 2022, // You have to set a constant to a value because 
      priceFrom_2021 = 39.99;  // declaration cannot be empty as 'let' above.
// initialPrice = 49.99  // Constant cannot be changed/updated anymore!

let discountText = `Up to ${discount}% off!`;  // Interpolation: Observe the backticks!
discountText = `Hey!


${discount}% off on ${productName.toUpperCase()}!`;

console.log(discountText, "with length:", discountText.length); 
/*
    html converts those new lines above to a whitespace but console log prints them.
*/

console.log(
    "'priceFrom_2021' variable type:", typeof priceFrom_2021,  // output: number
    "\nRemoval year:", ++productRemovalYear,  // productRemovalYear++ works as well but beware while using it.
    // ++yearSold  // Increment doesn't work for constants!
)

console.log(
    "The product was sold in " + yearSold.toString() + " before",
    `with the rate of ${discountRate}.`  // Note that "abc" is ignored while parsing above.
)

changeMessages(
    message = titleText,
    discount = discountText,
    );

let userProperties = {  // This is an object.
    firstName: "Mert",
    lastName: "Gül",
    age: 33.02,
    isMale: true
}

console.log(
    `User name: ${userProperties.firstName}\n`,
    typeof userProperties  // output: object (SIMILAR to "dictionaries" in Python, "hashes" in Ruby)
);


let price = "19.999"
price = Number.parseFloat(price);

if (price === NaN) {  // null, undefined, NaN are false.
    changeMessages("Not NaN Title", typeof price);
}

else if (+price.toFixed(2) === 20.00) {  // toFixed returns string. We added + as a prefix to make it an integer.
    changeMessages(
        `New Price: ${typeof +price.toFixed(1)}`,
        `Only ${price.toFixed(2)}`
        );  // btw, toFixed still thinks 'price' is a string :(
}

// ternary operator
let errorType = (typeof price === "number") ? "Number error": "Other errors";
console.log("Error type:", errorType);

/* Difference between '==' and '==='
    if (1 === "1"): false  ---> Different type! 'Strictly Equal to' or 'Identically Equal to'
    if (1 == "1"): true  ---> Converts the int to str.
*/

// loops
for (let i = 0; i <= 3; i++) {
    console.log("[INFO]:", i+1, "Mississippi")
}

let c = 5;
while (c > 0) {
    console.log("[INFO]:", c, "Mississippi");
    c--;
}

c2 = 10;
do {
    console.log("Count down from 10:", c2);  // Runs at least once.
    c2--;
} while (c2 >= 15);

// more of objects
let password = Symbol();
let person = {
    account_name: "Mert",
    age: 33,
    [password]: "123_!*psswrd",  // information hiding
    showInfo: function(some_var) {
        console.log(`You cannot retrieve ${this.account_name}'s password.`);
        console.log(some_var, "is printed on the console.");
    }
};
person.showInfo("Some Variable");
console.log(person.password);  // undefined
console.log(person[password]);  // 123_!*psswrd


