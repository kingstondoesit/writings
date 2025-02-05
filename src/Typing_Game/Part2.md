# Build Your First Typing Game with JavaScript - Part 2

![cover-image](https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F8v3d0fnq6cf5w1l2ho22.gif)

This is a continuation of the **Build your first typing game with Javascript** series.

In the [first part of the tutorial](./Part1.md), we laid out the game's functional requirements and structured the webpage to display a portion of its interactive content.

You'll find the files in the current working directory from part one [here](https://github.com/kingstondoesit/typing-game-complete/tree/part-two-starter).

We will proceed by delegating the game's functional components to separate units that handle fractions of the game's logic. These units are generally described as **modules**.

## Modules; what are they?

A module is a self-contained unit of code that can be imported and used in other files within a project.

Modules could feature functions, variables, classes, or objects that perform a specific task or a set of related tasks.

Once a module is created, you can "invite" or import it into other project parts whenever you need to handle a specific functionality it emits.

This is a common practice in web development because it allows for:

- **Better organization**: As code is broken into manageable pieces.

- **Reliable testing**: Individual modules can be tested in isolation to ensure their functionality before integrating with other modules.

- **Ease of maintenance**: You can update or debug specific modules without affecting the rest of the project.

- **Code reusability**: Modules can be reused in different parts of a project, or even across entirely different projects as libraries.

## Creating a Module

Now that you have been introduced to the concept of modules, let's create a module.

### Quotes Module

In the root directory, create a new folder named `modules` and add a new file `quotes.js`.

We need 20 random quotes for the module content.

#### Quotes Module - Variable Definition

Draft quotes from your favorite philosophers (eg. Professor Dumbledore, Sherlock Holmes) or prompt a Large Language Model like ChatGPT to generate them within a specific sentence length limit.

Use the following prompt (without the quotation):

```sh
'Generate 20 Quotes from *philosopher_name* with a sentence range of 10 - 12 words.
 Present the quotes in a Javascript string array format.'
```

Or use the sample response below. Copy the response into the newly created file and ensure the variable name is defined as `quotes`.

```javascript
//./modules/quotes.js
export const quotes = [  
    "Happiness can be found even in the darkest of times.",  
    "Words are, in my not-so-humble opinion, our most inexhaustible source.",  
    "It matters not what someone is born, but what they grow to be.",  
    "It is our choices, far more than our abilities, that show who we are.",  
    "You must be the change you wish to see in the world.",  
    "The truth is a wonderful yet terrible thing, and should therefore be treated with caution.",  
    "Do not pity the dead, Harry. Pity the living.",  
    "The greatest magic is the magic of love and friendship.",  
    "We are only as strong as we are united, as weak as we are divided.",  
    "You will find the world is full of unusual things.",  
    "The best of us must sometimes eat our words.",  
    "It is the quality of one's convictions that determines success.",  
    "Perhaps those who are best suited to power are those who never sought it.",  
    "To have been loved so deeply will give us some protection.",  
    "A good man's life should be measured by his kindness.",  
    "Sometimes you must choose between love and duty, each has its cost.",  
    "The future is unwritten. It is ours to shape.",  
    "The long term is the key to understanding our short-term actions.",  
    "Fear of a name increases fear of the thing itself.",  
    "Even the smallest person can change the course of the future.",  
    "A man who is a master of patience is a master of everything else."  
];  
```

Notice the inclusion of an `export` term before the variable declaration? The **export** keyword is used to expose the contents of a module so they are accessible by other parts of a project.

> **Note**: The concept of modules is based on the principle of dependability. A file component qualifies as a module only when it has shared its functionality and provided value to another component.

Awesome. Now we have a module holding an array of quotes that will be utilized in the game.

#### Windows Storage Property

Recall that one of the expectations for our game is to track and (possibly) retain typing records after each play session. These typing records will typically be stored on the web browser in a compartment known as [Local Storage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage).

An alternative location for storing this kind of data (A.K.A **Web tokens**) is the Window [Session Storage](https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage), which is similar to local storage but only available for the duration of a user's current browsing session.

We would use the Local storage option to store the player's high scores so that the records persist even after the user exits the page.

### Highscores Module

Create a new file named `highscores.js` in the `modules` folder.

In this file, we define four functions to store, fetch, display, discard, and erase typing records as needed within the game.

**N/B**: A **score** refers to the time it takes a player to finish typing a quote and a list of accumulated scores makes up the typing records.

We want to store at most 10 scores per time.

#### Highscores Module - Function Definitions

1. This `saveHighScore(param*)` function takes a *score* parameter and does four things.
    - It adds the score to the list of highscores in local storage.
    - Ranks all highscores (including the newly added score) in ascending order - quickest to slowest.
    - Stores only the top 10 scores after sorting.
    - Returns a Boolean value indicating whether the new score was retained (True) or not (False).

    ``` javascript
    function saveHighScore(score) {
        let highScores = getHighScores(); // Gets all highscores in local storage
        highScores.push(score); //Adds the new score to the list of highscores
        highScores.sort((a, b) => a - b); // Sorts scores in ascending order
        if (highScores.length > 10) {
            highScores = highScores.slice(0, 10); // Keeps only the top 10 scores
        }
        localStorage.setItem('highScores', JSON.stringify(highScores)); //saves top 10 scores to local storage
        return highScores.includes(score); // Returns true if the current score is in the top 10
    }
    ```

2. The `getHighScores()` function retrieves an array of highscores in [JSON](https://www.w3schools.com/js/js_json_intro.asp) format from the browser's local storage.

    Notice the use of [ternary operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Conditional_operator) (`?` and `:`)? Ternary operators serve as a concise alternative to traditional conditional statements.

    ``` javascript
    function getHighScores() {
        const highScores = localStorage.getItem('highScores');
        /* Checks if there are any high scores stored.
        Parses the JSON string into an array if true; else, returns an empty array.*/
        return highScores ? JSON.parse(highScores) : []; // concisely written conditional
    }
    ```

    Without ternaries, the above return line would read:

    ``` javascript
    // traditional conditionals 
    if (highScores) {
        return JSON.parse(highScores);
    } else {
        return [];
    }
    ```

    > ⚠️ Ternary operators are not direct substitutes for if-else statements; they do not serve in all cases and are best suited for simple, clear-cut scenarios where concision is justifiable.

3. We'll use another function `displayHighScores()` to handle how scores are displayed after each game session.

    ``` javascript
    function displayHighScores() {
      const highScores = getHighScores(); // Gets all highscores in local storage

      // Formats the highscores into a numbered list
      const formattedScores = highScores
      .map((score, index) => `${index + 1}. ${score} seconds`)
      .join('\n');

      // Returns the formatted scores as a single string element
      return formattedScores;
    }
    ```

4. Finally, the `clearHighScores()` function erases all typing records from the browser's local storage.

    ``` javascript
    function clearHighScores() {
      localStorage.removeItem('highScores');  // clear all high scores from local storage
    }
    ```

> **Note**: These are top-level functions and do not need to be arranged chronologically.

For reference, here's the order we've gone with.

```javascript
// ./modules/highscores.js
export function displayHighScores() { // in-line function export
  const highScores = getHighScores();

  const formattedScores = highScores
    .map((score, index) => `${index + 1}. ${score} seconds`)
    .join('\n');

  return formattedScores;
}

function saveHighScore(score) {
  let highScores = getHighScores();
  highScores.push(score);
  highScores.sort((a, b) => a - b);
  if (highScores.length > 10) {
    highScores = highScores.slice(0, 10); 
  }
  localStorage.setItem('highScores', JSON.stringify(highScores));
  return highScores.includes(score); 
}

function getHighScores() {
  const highScores = localStorage.getItem('highScores');
  return highScores ? JSON.parse(highScores) : [];
}

function clearHighScores() {
  localStorage.removeItem('highScores');
}

export { clearHighScores, getHighScores, saveHighScore }; // functions exported as objects
```

> 💡 **Pro Tip**: Exporting functions as objects work the same as in-line export statements. However, the latter is usually preferred for smaller modules while the former is ideal for larger modules requiring additional control and organisation.

Excellent!

Now that we have both **quotes.js** and **highscores.js** modules set up, we have a solid base to get the game fully functional.

The game's main logic consists of triggers that signal the browser what to do and when to do what as players interact with the web page elements.

For example, in [this demo](https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fxhkf1wkloky19qr0r4py.gif), you see the page elements change when the start button is clicked. Some hidden elements become visible, while those initially visible disappear as the game moves to its second phase.

This transition is made possible by the `click` event trigger.

Event triggers are an integral part of Event Listeners, and in [the next and final part](./Part3.md) of the tutorial, we will explore the concept, its syntax, and its implementation.
