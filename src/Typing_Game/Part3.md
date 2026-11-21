# Build Your First Typing Game with JavaScript - Part 3

![cover-image](https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F6qd8flnl24rjda70xuuh.gif)

If you're not quite sure how we got here, refer to the [starter section](./Part1.md) of the series and follow through to [the previous part](./Part2.md) where we created Modules for the game, discussed the Window storage property, explained Ternary operators, and briefly introduced Event triggers.

Also, here's [the link](https://github.com/kingstondoesit/typing-game-complete/tree/part-three-starter) to the files in the tutorial's current working directory.

The game is still unplayable at this stage and we'll focus on bringing it to life, mostly in **script.js**. This file serves as the module assembly location where we'll implement the game's main logic.

> 💡 **Heads Up**: With concept assimilation in focus, there will be a few instances where you'll be expected to engage in exercises that reinforce what is being explained. Feel free to play around, break things, and add functionalities that reflect your preferences.

## Step 1 - Importing Modules

We've previously addressed how module contents can be exported with the `export` keyword, but how do you use them in another part of a project?

The Javascript `import` syntax calls the components of a module in a relative path in the state in which they were exported.

For example, the following illustrates importing module components exported as objects.

``` javascript
import { export1 }  from "module-name"; // singular module entity import
import { export1, export2, ... }  from "module-name"; // multiple module entity import
```

There are a number of scenarios where you write the import statement differently depending on the nature of the external module or how you want to access its components, all covered in [this documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import).

We'll import the quotes array variable from **quotes.js** and the functions we defined in the **highscores.js** module.

Open **script.js** on a new tab in VS Code and insert the following atop the empty page.

``` javascript
// ./script.js
import { quotes } from './modules/quotes.js';
import {
  saveHighScore,
  displayHighScores,
  clearHighScores,
} from './modules/highscores.js';
```

Great!

Ideally, you should only import entities that handle specific functionalities within a file component. It is not unusual to dive right into the component's algorithm and then occasionally scroll to the top of the file to import the required modules as you go.

## Step 2 - DOM Element selection

HTML documents consist of a collection of nodes that make up the [DOM tree](https://www.w3schools.com/js/js_htmldom.asp), also known as the building block of web applications. These nodes represent all existing HTML components and could be elements (such as divs, paragraphs, headings, buttons, etc.), texts, or [attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes).

To interact with the DOM with Javascript, you'll typically use the following methods to select node elements:

1. The [`document.getElementById()`](https://www.w3schools.com/jsref/met_document_getelementbyid.asp) method lets you select a single element by its unique ID.

    For example, this selects the start button assigned to the ID `start` in **index.html**.

    ``` javascript
    const startButton = document.getElementById('start');
    ```

    Fancy a challenge? Here's a simple exercise for you.

    Below is a list of IDs and their proposed variable names.

    Use the `document.getElementById()` method to select each element assuming the example syntax above goes by '*start* as ***startButton***':
    - prompt_start as **promptStart**
    - prompt_again as **promptAgain**
    - typed-value as **typedValueElement**
    - quote as **quoteElement**
    - timer as **timerElement**
    - welcome as **welcome**
    - reset as **resetBtn**
    - reset-div as **resetDiv**

2. The [`document.getElementsByClassName()`](https://www.w3schools.com/jsref/met_document_getelementsbyclassname.asp) method selects all elements featuring a specific class name and returns an [HTMLCollection](https://www.w3schools.com/jsref/dom_obj_htmlcollection.asp) of the elements, which can be accessed by their index.

    We select the form element with the class name `form`. By doing this, we can change the display state of the input textbox.

    ``` javascript
    const form = document.getElementsByClassName('form');
    ```

3. The [`document.querySelector()`](https://www.w3schools.com/jsref/met_document_queryselector.asp) method is more versatile; you use it to select the first element that matches any specified [CSS selector](https://www.w3schools.com/css/css_selectors.asp).

    For example, to select the first element in a DOM with the class `myClass` or the ID `myId`, you use `document.querySelector('.myClass')` and `document.querySelector('#myId')` respectively.

    The major difference with the previous methods is the prefix annotation in the parameter names, as you've noticed with the dot(`.`) for classes and the hash(`#`) for IDs in the above example.

    Select the `<div>` with the class `quotes`.
  
    ``` javascript
    const quotesDiv = document.querySelector('.quotes');
    ```

The [DOM API](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model#html_dom) provides [various methods and properties](https://developer.mozilla.org/en-US/docs/Web/API/HTML_DOM_API) for interacting with HTML documents. We've just mentioned a few popular ones but the list is inexhaustive.

If you completed the challenge exercise correctly, coupled with the two other element selection methods listed, you should now have the following in **script.js**.

``` javascript
import { quotes } from './modules/quotes.js';
import {
  saveHighScore,
  displayHighScores,
  clearHighScores,
} from './modules/highscores.js';

// Selected HTML elements
const quoteElement = document.getElementById('quote');
const typedValueElement = document.getElementById('typed-value');
const promptStart = document.getElementById('prompt_start');
const promptAgain = document.getElementById('prompt_again');
const startButton = document.getElementById('start');
const timerElement = document.getElementById('timer');
const welcome = document.getElementById('welcome');
const resetBtn = document.getElementById('reset');
const resetDiv = document.getElementById('reset-div');
const form = document.getElementsByClassName('form');
const quotesDiv = document.querySelector('.quotes');
```

## Step 3: Display State Handlers

The following establishes key functions to handle the display state of the selected HTML elements in the different phases of player interaction.

Add these under the selected HTML elements.

``` javascript
....

// Function to hide the prompt and related elements  
const hidePrompt_Button = () => {  
  promptStart.className = 'none'; // Hides the promptStart element
  promptAgain.classList.add('none'); // Adds 'none' class to promptAgain 
  startButton.style.visibility = 'hidden'; // Hides the start button  
  welcome.style.display = 'none'; // Hides the welcome message  
  resetDiv.style.display = 'none'; // Hides the reset button div  
};  

// Function to show prompt and related elements  
const showPrompt_Button = () => {  
  promptAgain.classList.remove('none'); // Removes 'none' class to show promptAgain  
  startButton.style.visibility = 'visible'; // Makes the start button visible  
  resetDiv.style.display = 'inline-block'; // Shows the reset button div  
};  

// Function to display the form element  
const showForm = () => {  
  form[0].style.display = 'block'; // Shows the first(and only) form element
  quotesDiv.classList.add('active'); // Adds the class 'active' to quotesDiv 
};  

// Function to hide the form  
const hideForm = () => {  
  form[0].style.display = 'none'; // Sets the first(and only) form element display to hidden 
  quotesDiv.classList.remove('active'); // Removes the class 'active' from quotesDiv  
};  

// Function to show the timer  
const showTimer = () => {  
  timerElement.classList.remove('none'); // Removes 'none' class to show the timer  
  timerElement.style.display = 'inline-block'; // Sets the timer to display as inline-block  
  timerElement.innerText = '0'; // Initializes the timer text with number '0'

// Disable input text box and default attributes
typedValueElement.disabled = true;
typedValueElement.setAttribute('autocomplete', 'off');
typedValueElement.setAttribute('autocorrect', 'off');
};
```

>**Note**: **....** indicates unchanged code.

We've just grouped the various elements' respective visibility states under functions that can be parsed as event handlers. When called, these functions dynamically change the display of their components as defined.

We also disabled the input text box and modified some of its default attributes.

You'll appreciate this grouping better from **Step 5** onwards, where we nest these functions in event listeners. You can always scroll back to this section to reference each function where necessary.

## Step 4: Timer Countdown Logic

Next, we implement a timer that tracks how long a player has been typing and create another function that stops the timer.

``` javascript
....

// Initializes variables to track the start time and calculate the elapsed typing time
let startTime = Date.now(); // variable initialized as the current date and time in milliseconds
let timerInterval = 0; // variable initialized for the timer interval as integer '0'

// Function to start the timer
const startTimer = () => {
  startTime = Date.now(); // Resets the start time to the current date and time
    
  // Sets an interval to update the elapsed time every second
  timerInterval = setInterval(() => {
  const elapsedTime = ((Date.now() - startTime) / 1000).toFixed(0); // Calculates the elapsed time in seconds and round to the nearest whole number
  timerElement.innerText = `${elapsedTime}`; // Updates the timer element's text to display the elapsed time
}, 1000); // interval set to 1000 milliseconds (1 second)
};

// Function to stop the timer
const stopTimer = () => {
  clearInterval(timerInterval); // clears the interval to stop the timer updates
};
```

The `startTimer()` function when invoked, continually calculates the elapsed time through the [setInterval](https://www.w3schools.com/jsref/met_win_setinterval.asp) function. The elapsed time is displayed in the `timerElement`, updating every second until the `stopTimer()` function is called.

The `stopTimer()` function halts the count and clears the timer interval.

That's all there is to the timer logic.

## Event Listeners

[Event listeners](https://www.w3schools.com/js/js_htmldom_eventlistener.asp) are essential for creating interactive web experiences. By attaching event listeners to markup elements, we can instruct web pages to respond in a specific way when users perform certain actions.

### Implementing Event Listeners

The event listener syntax executes a function when a specific event occurs on an HTML element. The function executed is commonly described as an **Event Handler**.

We typically use the `addEventListener` method to implement an event listener in Javascript.

``` javascript
<element>.addEventListener(event, function, useCapture?);
```

Here's a breakdown of the syntax properties:

- **element**: This is the targeted HTML element (e.g. A button). We already covered how they can be selected under the DOM element selection section.

- **event**: A string representing the event type, such as `'click'`, `'mouseover'`, `'scroll'`, `'keydown'` and [several others](https://developer.mozilla.org/en-US/docs/Web/Events#event_index).

- **function**: The callback function(s) that executes when the event occurs on the HTML element. This can be a named function, an anonymous function (unnamed), or [an arrow function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions).

- **useCapture** (optional, hence the question mark): A boolean value indicating [how the event should be captured](https://stackoverflow.com/questions/7398290/unable-to-understand-usecapture-parameter-in-addeventlistener). The default value is `false`.

An experimental example of how to use the `addEventListener` method to listen for a click event on a button is illustrated below. We'll dynamically change the style setting of our form element with the `showForm` display state handler.

Add this line of code to **script.js**. **Save** the file and start up ***live server***. 

``` javascript
startButton.addEventListener('click', showForm);
```

After the project loads in the browser, click the **Start** button.

You'll notice that the form displays but you cannot type anything into it. This is because the input area was previously disabled.

Let's fix this.

Erase the above event listener and replace it with the following.

``` javascript
startButton.addEventListener('click', () => {
  showForm();
  typedValueElement.disabled = false;
  typedValueElement.focus();
}
);
```

Save the changes and click the **Start** button again.

![difference](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fir90j889qaeqkoiik4cp.gif)

In this example, we've seen two different event handler cases.

In case 1, we call the `showForm` function on the `'click'` event as the only event handler without parentheses.

However, in case 2, we use an arrow function as a callback to show the form, enable the input field, and focus on it immediately after the form is displayed.

So, yes, you can execute multiple functions and statements in response to an event. Just take note of the parentheses `()` usage in both cases, as they determine how functions are invoked.

## Game Mechanics

Now that you understand how event listeners work, **clear** the above experimental lines of code.

The game's mechanics entail the entire series of events that occur between when the player starts the game and when they complete typing the group of words presented in the randomly selected quote. You can type just about anything into a form; however, we want what is being typed to align with the quote that needs to be matched.

We have the task of preparing the interactive space for the player and imposing checks that evaluate the player's input to verify its correctness.

### Step 5: Start Button Event Listener

To prepare the game's interactive space, begin by replacing the cleared experimental code with the following.

``` javascript
// Initializes the word list variable and word index variable to track the current word  
let words = [];  // variable initialized as an empty array
let wordIndex = 0; // variable initialized as an integer zero
let isTimerStarted = false; // flag to control the startTimer funtion
```

This initializes three crucial variables the start button event listener will utilize:

- The variable `words` will store the word list extracted from the selected quote.

- The `wordIndex` variable will track the player's current word position in the word list.

- Because we do not want to call the `startTimer` function incorrectly/prematurely, we use a boolean flag `isTimerStarted` to effectively control when it is called into action.

Below the initialized variables, we encapsulate the functions and statements that should execute when you click the start button.

``` javascript
....

startButton.addEventListener('click', () => {  
  // Hides unneeded elements when the game starts  
  hidePrompt_Button();  

  // Generates a random index to select a quote from the quotes array  
  const quoteIndex = Math.floor(Math.random() * quotes.length); // Takes the quotes length (20) and selects a random number within range
  let quote = quotes[quoteIndex]; // Assigns the selected item value quoteIndex represents to the variable 'quote'

  words = quote.split(' ');  // Splits the selected quote into an array of individual words 
  wordIndex = 0; // Set wordIndex to zero

  // Creates an array of span elements for each word to allow for individual highlighting  
  const spanWords = words.map((word) => `<span> ${word} </span>`);  
    
  // Sets the inner HTML of the quote element to the formatted words  
  quoteElement.innerHTML = spanWords.join('');  
  quoteElement.classList.add('quote'); // Adds the class 'quote' to style the quote element
  quoteElement.childNodes[0].className = 'highlight'; // Sets the class of the first word to 'highlight'
 
  // Show the timer, show the form
  showTimer();     
  showForm();
    
  isTimerStarted = false; // Timer not started yet  
  typedValueElement.value = ''; // Clear previous input, if any
  typedValueElement.disabled = false; // Enable the input field  
  typedValueElement.focus(); // Set focus on the input field for typing  
});  
```

On clicking the start button we immediately hide the elements we do not need by parsing and calling the `hidePrompt_Button()` function first.

We then use the [`Math.floor(Math.Random()...)`](https://www.w3schools.com/js/js_random.asp) methods to randomly select a quote from the quotes array, assigning the resulting value to the variable `quote`.

The selected quote is split into a list of individual words and the new word list is assigned to the initially empty array `words`.

This word array is then transformed from an array of single-word strings into an array of HTML `span` elements with the `.map()` method.

We join the now HTML-transformed words, parse them into the `quoteElement`, add the `'quote'` CSS class to it for some animation, and highlight the first child of the element (the first word span element).

We then display the timer element and the form, specify that the timer should not start immediately, and finally, enable and focus the input text box.

![startbtneventlistener-ezgif](https://hackmd.io/_uploads/SybbLgUG1x.gif)

**Okay. That was a lot to take in.**

>💡 **Pro Tip**: When working with unfamiliar code, there's a tendency you may still be uncertain of what value a variable hold despite the description(s) accompanying them. You can always use the `console.log(<variable>)` method to inspect variable values and behavior in your browser's console.

### Step 6: Typed Value Element Helper Functions

Moving forward, the following helper functions facilitate the game flow and validate player inputs. We will go over them in detail.

``` javascript
....

// Validates the typed word against the current word and the current typed word.
function validateTypedWord(typedValue, currentWord, currentTypedWord) {  
  if (typedValue.endsWith(' ') && currentTypedWord !== currentWord) {  
    return false;  // Returns false if the typed value ends with a space and does not match the current word,
  }  
  if (typedValue.length < currentTypedWord.length) {  
    return false; // Returns false if the typed value is shorter than the current typed word.
  }  
  return currentWord.startsWith(currentTypedWord); // Returns true if the current word starts with the current typed word.
}

// Highlights the currently typed word in the quote 
function highlightCurrentWord() {  
  for (const wordElement of quoteElement.children) {  
    wordElement.className = '';  // Clears the previously highlighted word(s)
  }  
  quoteElement.children[wordIndex].className = 'highlight'; // Applies the class 'highlight' to the current word element.
}

// Advances to the next word in the quote.
function advanceToNextWord() {  
  wordIndex++;  // Increments the word index
  const completedText = words.slice(0, wordIndex).join(' ') + ' ';  
  typedValueElement.value = completedText; // Updates the typed value to include all the completed words

  highlightCurrentWord(); // Calls the highlightCurrentWord functions on the current word.
}

// Function to handle the game completion
function endGame() {  
  stopTimer();  // Stops the timer
  showPrompt_Button(); // Shows the prompt button
  hideForm(); // Hides the input form
  typedValueElement.disabled = true; // Disables the input area.
  quoteElement.innerHTML = ""; // Clears the quote element


  const elapsedTime = ((new Date().getTime() - startTime) / 1000).toFixed(2); // Calculates the elapsed time
  const message = `🎉CONGRATULATIONS! You finished in ${elapsedTime} seconds.`; // Displays congratulatory message 

  // Checks if elapsedTime falls in top score category (Top 10)
  const isTopScore = saveHighScore(elapsedTime); 
  const highScoreMessage = displayHighScores(null, isTopScore ? elapsedTime : null); 

  alert(message + '\n' + highScoreMessage); // Displays high scores.
}
```

1. The `validateTypedWord(typedValue, currentWord, currentTypedWord)` function takes three parameters whose respective values we will define. Essentially, this function compares the typed input with the current word in the quote to ascertain its validity.

    If the word being typed corresponds with or is on track to match the current word from the word index, it returns a `true` value.

    However, it returns `false` if:
      - The typed value ends with a space and the currently typed word does not match the current word in the quote (indicating an incorrect entry).
      - The length of the typed value is less than that of the current typed word (indicating an incomplete word).

2. The `highlightCurrentWord()` function provides visual feedback that helps players track their progress by highlighting the HTML span element representing the currently typed word in the quote.

3. The `advanceToNextWord()` function progresses the game to the next word. It increments the word index and calls the `highlightCurrentWord()` function to highlight the latest word.

4. Finally, the `endGame()` function handles what happens when the game ends. It
    - Stops the timer.
    - Displays the '*play again*' prompt message and related elements like the reset and start buttons.
    - Hides and disables the input form.
    - Clears the quote element.
    - Calculates the elapsed typing time and formats the result to two decimal places.
    - Displays a congratulatory message.
    - Displays the current score and all saved high scores accordingly.

### Step 7: Typed Value Element Event Listener - Logic Flow, Success and Error Handling

We're almost done now. Writing the required helper functions was the first step in the player input validation puzzle.

If you try typing anything into the text box at this point, nothing still happens. This is because we have yet to;

- Assign a value to each of the `validateTypeWord` function parameters.
- Construct conditionals that logically utilize the helper functions in the input element's event listener.

The following code resolves all of these.

``` javascript
....

// Initialize an error flag to track input errors  
let errorFlag = false;  

// Adds an event listener for input on the typedValueElement  
typedValueElement.addEventListener('input', () => { 
  
  // Conditional to start the timer  
  if (!isTimerStarted) {  
    startTimer(); // Start the timer  
    isTimerStarted = true; // Set the flag to indicate the timer has started  
  }  
  
  // validateTypedWord function parameter definitions
  const typedValue = typedValueElement.value; // Gets the current value typed by the user 
  const currentWord = words[wordIndex]; // Gets the current word from the quote that needs to be typed 
  const typedWords = typedValue.trim().split(' '); // Splits the typed value into words and trim any trailing space
  const currentTypedWord = typedWords[typedWords.length - 1] || ''; // Gets the last typed word (the current word being typed)

  // Validates the typed word against the current word  
  if (validateTypedWord(typedValue, currentWord, currentTypedWord)) {  
    // If valid, reset the error class and flag  
    typedValueElement.className = '';  
    errorFlag = false;  

    // Checks if the current typed word matches the current word  
    if (currentTypedWord === currentWord) {  
      // If it's the last word, end the game  
      if (wordIndex === words.length - 1) {  
        endGame();  
      }   
      // If the user typed a space after the current word, move to the next word  
      else if (typedValue.endsWith(' ')) {  
        advanceToNextWord();  
      }  
    }  
  } else {  
    // If the typed word is invalid, set the error class and flag  
    typedValueElement.className = 'error';  
    errorFlag = true;  
  }  
});  
```

The timer initiates the count only after the player's first input. This is because we have called the `startTimer()` function in a conditional where `isTimerStarted` is not equal to `false`.

The conditionals that follow incorporate all the pre-defined helper functions.

Any return of `false` in the `validateTypedWord()` function indicates an error, which sets the error flag to `true` and applies the `'error'` CSS style to the input text box.

However, if the `validateTypeWord` function returns a `true` value (meaning correct word typing), then it;

- Clears the `'error'` CSS style and resets the error flag to `false`.
- Goes further to check if the most recently completed word is the last word on the quote's word list.
  - If that is the case, it calls the `endGame()` function.
  - However, if the most recently completed word is not the last on the word list and is followed by a space, it moves to the next word by calling the `advanceToNextWord()` function.

![typedValuedemo](https://hackmd.io/_uploads/H1VUhs_G1x.gif)

Fantastic!

### Step 8 - Typed Value Element Keydown Event Listener

You might not have noticed yet, but there's a slight bottleneck in the typing experience.

Earlier, we saw a few ways to alter the default attributes of a form element but there's one more we haven't addressed.

Consider yourself in the player's shoes for another moment. While typing, you could accidentally hit the **Enter** key and trigger the default response behavior associated with pressing that key - usually submitting the form and refreshing the page. A page refresh effectively means starting the game afresh.

The player will most likely be unaware of this, and as the developer, you want to curb potential interruptions that mar their playing experience.

The following event listener attached to `typedValueElement` listens for the `'Enter'` [`'keydown'`](https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event) event and prevents this unintentional form submission from happening.

``` javascript
// Adds an event listener to prevent the default action when the Enter key is pressed
typedValueElement.addEventListener('keydown', (event) => {
    if (event.key === 'Enter') {
        event.preventDefault();
    }
});
```

Awesome!

Our game is now at least 95% functional. All that’s left is to sort the Reset Button's functionality.

## Step 9 - Reset Button Event Listener

The following sets up an event listener for the reset button element `resetBtn` to listen for a `'click'` event.

``` javascript
// Adds an event listener to the reset button to handle high score reset
resetBtn.addEventListener('click', () => {
    const userConfirmed = confirm( 'Are you sure you want to reset all high scores? This action cannot be undone.');

    if (userConfirmed) {
        clearHighScores();
        alert('High scores have been successfully reset.');
    }
});
```

On clicking the reset button, the web page responds with a confirmation dialog message. If the player confirms the action, it calls the function `clearHighScores()` from the **highscore.js** module to clear the scores and displays an alert notifying the user of the score reset success.

Here’s a quick way to test this functionality.

Go to **style.css**. Under the class `reset-div`, disable the display setting with comments and **Save** the file.

```css
/* ./style.css */
....
.reset-btn {
  position: relative;
}
  
.reset-div {
  position: relative;
  display: inline-flex;
  align-items: center;
/* display: none; */ /* hidden display setting deactivated */
}
....
```

Expectedly, the reset button shows up on the web page above the welcome message.

![reset-btn](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/hysciisjr3xggh1x7295.png)

Now **click** the reset button and verify that the event listener works as described.

**Revert** to the previous display setting of `reset-div` afterward by removing the CSS code comment and saving the file.

## Wrap Up

And there you have it. You have created a fully functional typing game!

Here's [the full demo](https://hackmd.io/_uploads/HkVPlQqfyl.gif).

## Resources and Further Reading

1. You'll find the complete code in [this repository](https://github.com/kingstondoesit/typing-game-complete).

2. Web development [tutorial reference](https://github.com/microsoft/Web-Dev-For-Beginners/tree/main/4-typing-game) from Microsoft.

## Additional Tasks

A simple challenge to stimulate your analytical and problem-solving capacity using your new-found Javascript knowledge. Give it a try.

👉 **Use a [modal](https://www.w3schools.com/w3css/w3css_modal.asp) to display the typing completion message instead of the built-in Windows dialog box.**

You can learn about creating modals from this tutorial by Traversy Media.

{{#embed https://www.youtube.com/watch?v=6ophW7Ask_0 }}

Your solution should be similar to what we have [ here](https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F6qd8flnl24rjda70xuuh.gif); however, you can customize the colors and themes to suit your preference.

>💡 **Task Hint**: 
>I. You'll structure a modal HTML element in **index.html**.
> II. Select the new modal elements (with IDs and classes) in **script.js**
>III.  For the modal message render logic, you'll make modifications to:
> - The `displayHighscores()` function in **highscores.js** and
> - The `endGame()` function in **script.js**

To submit:

1. Confirm that the new feature works on your browser.

2. Bundle your project folder with the working code in a compressed format (.zip, .rar, etc.).

3. Send over the bundled file to [kingstondoesitall@gmail.com](mailto:kingstondoesitall@gmail.com) with the email subject `Typing-Game Modal Message Solution by <your_name>`.

You'll get your submission reviewed and a feedback from us within 24hrs.

## Credits

This guide builds on Microsoft's typing-game reference documentation. Huge credits and a big 'thank you' go to pioneer author [Christopher Harrison](https://www.linkedin.com/in/geektrainer) without whose expertise and guidance all of this may not have been possible.

And also to you, the energetic, enthusiastic, and dedicated knowledge seeker who persevered through this action-packed tutorial, we are incredibly honored to help you demystify the developer path through series like these. We enjoyed putting this guide together with you in mind and can't wait to see you progress even further. ❤

---

If you found this tutorial helpful, you can support us:

- [Buy **TheTechED Junction** Coffee](https://buymeacoffee.com/kingstondoesit) ☕

- Share this resource with friends and colleagues 📩.

---
