# Build Your First Typing Game with JavaScript - Part 1

![cover-image](https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fxhkf1wkloky19qr0r4py.gif)

This is a step-by-step beginner's guide to building a minimalist typing game with JavaScript.

You'll learn how to set up an intuitive interface and manipulate the [Document Object Model](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model) (DOM) with key concepts like modules, event listeners, event handlers, and dynamic styling which constitute the backbone of responsive and engaging webpages.

By the end of the tutorial, you'll have built a fun, interactive game and acquired an enhanced practical understanding of the fundamentals of Javascript.

The tutorial is split into three (3) parts:

- Part one covers the following:

  - [Pre-requisites](#pre-requisites)

  - [Project environment setup](#project-environment-setup)

  - [Project Deliverables](#project-deliverables)

  - [Project structure](#creating-the-project-structure)

  - [Page markup and layout of interactive elements](#marking-up-with-html-and-css)

- [Part two](./Part2.md) discusses Modules, why they are important in web development and establishes key functionalities in module components.

- [Part three](./Part3.md) focuses on building the game's logic, integrating the established modules, and ensuring the game works as expected.

>💡 **Tip**: You can navigate to any part of interest. Each part includes a link to starter files representative of the tutorial's progress from the preceding section.

## Pre-requisites

We presume that you have (at least) prior theoretical HTML, CSS, and Javascript exposure.

It would be particularly advantageous if you're familiar with:

- Creating a form and a submit button (HTML)

- Styling elements using classes and IDs (CSS)

- the following Javascript concepts:

  - Creating and manipulating Arrays

  - Conditionals and conditional statements

  - Getting a Random number

  - Getting the current time

## Tools You’ll Need

- **An IDE (Integrated Development Environment)**: We will use Visual Studio Code alongside helper extensions.

- **A Web Browser**: Install MS Edge, Chrome, Firefox, or any other modern browser to view and test the output of your code.

## Project Environment SetUp

Before beginning any project, it is conventionally regarded as good practice to organize the development environment in a way that eases general workflow. Setting this up could involve downloading assets, installing required components, and sorting configuration files.

### Installing VS Code Extensions

Extensions are assets that assist development processes. They provide essential technical support so you have a smooth and efficient programming experience.

Install the following VS Code extensions:

- **Prettier - Code Formatter**: Enhances code readability with consistent formatting styles.

- **ESLint (Code Linter)**: Identifies and fixes common errors.

- **Live Server**: For real-time, development-phase code test.

![extension installation](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/a0jppkquy5vfor2j170r.gif)

Here, we illustrate the extension installation process with `ESLint`.

To install any extension,

- Click on the Extensions icon on the left sidebar of VS code or press `Ctrl + Shift + X`.

- Enter the extension name in the search bar and click on the most relevant result (usually the one with the most downloads).

- Click "Install".

> We recommend restarting Visual Studio code after installation for proper IDE integration, although some extensions may not require it.

## Project Deliverables

Pause for a minute and think about the features that make up a typing game. If you have played one in the past or used any typing tool, you will concur that they primarily:

- Provide an intuitive and interactive interface to the user or player.

- Display a randomly generated word, quote, or sentence for the player to type.

- Track and compare the player's input against the presented text or group of texts.

- Highlight correct and incorrect submissions, and signal erroneous input in real-time.

- Alert the player upon game completion and report tracked data.

- Store typing records.

More advanced features could include measuring typing accuracy and typing speed in Words Per Minute (WPM); however, we'll focus on the elementary. 

Now that we are clear on the game's deliverables, let's begin by initiating a basic project structure.

## Creating the Project Structure

Start up a new project folder and create the following files:

- `index.html`
- `style.css`
- `script.js`

![create index.html, style.css, and script.js](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/8e341n3ah6k44sji96gl.png)

`index.html` houses all our markup. It is the file the web browser loads by default, and the resulting webpage which players interact with.

`style.css` serves as our webpage stylesheet.

`script.js` will hold all the underlying logic governing the typing game's behaviour.

### Marking up with HTML and CSS

Open the **index.html** file in a new tab.

In VS code, use the exclamation mark (`!`) [Emmet Abbreviation](https://code.visualstudio.com/docs/editor/emmet) on the newly created HTML document. This automatically populates the page with a basic HTML boilerplate.

![index.html after exclamation mark](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/kz84qycvd6wjfgokjbot.gif)

If you use an IDE different from VS Code without the emmet abbreviation feature, you can grab and use the code snippet below.

#### Head Element

An HTML head is a vital part of an HTML document. It contains essential metadata like the webpage title, logo, description, links to stylesheets, scripts, and other resources that help define how the page behaves and how it is displayed in the browser to users.

Modify the page title to suit the project's purpose and use [this image](https://github.com/kingstondoesit/typing-game-complete/blob/completed/favicon.jpg) as the page logo. Download and save the image as favicon.jpg in the project's root location.

```html
<!-- index.html -->
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Typing Game | My First Typing Game with JavaScript</title>
        <link rel="icon" type="image/png" sizes="32x32" href="./favicon.jpg" />
      </head>
      <body class="container">
      <!-- Interactive content goes in here -->
      </body>
```

Below the `<head>` element we instantiate the HTML body with the class `container`. This is where all the interactive content will be embedded, starting with the page header.

#### Header Element

The header HTML section comprises a collection of information (mostly) statically positioned at the top of a webpage. It is typically used to convey a website's theme, display announcements, promotions, and useful links for easy navigation.

We, however, do not use the header element optimally here; it is solely used to maintain semantic convention.

Copy the following code block and insert it in the body element:

```html
.... 
<body class="container">
    <header>
        <nav class="reset-btn">
          <div class="reset-div" id="reset-div">
            <p id="reset-msg">reset typing records</p>
            <button id="reset">
              <i class="ri-reset-left-fill"></i>
            </button>
          </div>
        </nav>
        <h1 id="welcome">Welcome to typing game!</h1>
        <h1><time id="timer" class="timer none" datetime=""></time></h1>
      </header>
....
```

> **Note**: `....` indicates unchanged code.

The above header represents the initial set of the game's interactive content and has three notable elements:

- A `h1` element to display a welcome message to the player.

- Since the game will store typing records as mentioned in the deliverables, we include a reset button within the `nav` element so a player can erase all records and revert to a clean slate when they want to.

- Lastly, a second `h1` element that wraps the element `<time>`. This h1 element holds the timer value, and will only be displayed when the game begins.

> The `<i>` tag implements a reset button icon sourced from a third-party style package called **remixicon**.

#### Style Sheet and Reset Button Icon Import

We'll look at what we have done so far, but before that, let's add some styles to make our webpage look appealing.

Head to the style sheet and implement all the styles [here](https://github.com/kingstondoesit/typing-game-complete/blob/completed/style.css). Copy everything in the code space and paste it inside your **style.css** file.

```css
/*./styles.css

/* Base Styles */
body {
background-color: #fefeff;
color: hsl(210, 10%, 20%);
text-align: center;
margin: 1.5em;
font-size: 130%;
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
display: flex;

}
.container {
justify-content: center;
align-items: center;
display: flex;
flex-direction: column;
height: 100vh;
margin: auto;
}

/* Header Styling */

/*....(truncated)
```

Next, revisit the HTML document and link the stylesheet in the `head` element.

Also, include the link to the remixicon webpack. This lets us use the custom reset button icon within our markup.

```html
<!-- index.html -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Typing Game | My First Typing Game with JavaScript</title>
    <link rel="icon" type="image/png" sizes="32x32" href="./favicon.jpg" />
    <!-- style.css file linked!-->
    <link rel="stylesheet" href="style.css" />
    <!-- Remix icons imported!-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css"/>
  </head>
  ....
```

Having imported the required styles, let's see what our webpage looks like.

On the bottom right of VS code, click ***Go live*** to run live server. This should load up all the content in **index.html**.

![live-server](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/cbbv66q3uafxsfpfrrao.gif)

If the page does not load automatically, open your web browser and go to this address [http://127.0.0.1:5500/](http://127.0.0.1:5500/).

You should see this in the browser window:

![image of index.html with the welcome message and prompt](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/nhsuzwp9f1ca6yjnjpsj.png)

Keep the browser and live server running as we'll need them for feedback as we progress.

#### Prompt and Quote Elements

Back to our markup in VS code, add the following directly under the `header` element:

```html
....
<div class="quotes">
  <div>
    <p id="prompt_start">
      Practice your typing skills with a quote from Professor Dumbledore.
      <br />
      Click the <strong>Start button</strong> to begin!
    </p>
    <p id="prompt_again" class="none">
      Click the <strong>Start button</strong> to play again!
    </p>
    <p id="quote" class="quote"></p>
  </div>
</div>
```

Here, the paragraph with the ID `prompt_start` provides instructions to the player on how to start the game.

There is also a secondary paragraph with the ID `prompt_again` (set to hidden with the class `none`). This element becomes visible at the end of each game session and prompts the user to play another game.

An empty paragraph with the ID `quote` displays a random quote fetched from a quote module.

Summarily, the above code block contains elements that guide user interaction.

#### Typing Area and Start Button

The typing area of the webpage is a form with the class `form`, designated for players to type into as they attempt to match a presented quote.

Beneath the form, we place the start button which a player clicks to initiate the game.

Insert the following code under the `<div>` with class `quotes`

```html
....
<div class="input">
  <form action="" class="form">
    <input
      type="text"
      aria-label="current word"
      id="typed-value"
      class="form-input"
    />
  </form>
  <button type="button" id="start" class="form-btn">Start</button>
</div>
```

The `typed-value` ID assigned to the text input field is crucial in the game's context. It will enable tracking of the characters a player is typing or has already typed. The corresponding typed value determines the player's in-game and typing completion status.

Here's what the webpage should look like at this point.

![welcome message with start button](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/e5x9mi71lkht331vk1pk.png)

>**Note**: Live server automatically reloads the webpage and displays the updated content whenever the project gets modified.

Notice the missing element in the just-added code? 

One dominant feature in the game's logic is the alternating display of most components when the game is being played and when it is in a non-active state.

In this case, we set the form element directly to hidden without using the class `none` as we did with a few elements earlier (*timer*, *prompt_again*, etc.). Here's a peek at the CSS statement in the stylesheet.

```css
/* ./styles.css

....

/* Hidden Elements */
  .none {
      display: none;
    }

/* Form Element*/
.form {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3rem;
  margin-top: 2rem;
  display: none;
  background-color: hsl(201, 30%, 89%,);
}

/*....(truncated)
```

The idea of having a style identifier for the 'no-display' purpose is reusability, so, whenever you need to make an element invisible, you apply the class `none` to it.

Although both methods have their respective use cases, these properties can all be accessed and changed dynamically as we will learn subsequently.

## Recap

So far, we have established a solid foundation for our typing game.

We outlined the game's core deliverables, set up the development environment, and integrated helper tools like Prettier, Eslint, and Live Server in our IDE.

We designed the game's layout defining the header section, quote section, and typing area in **index.html**.

Finally, we styled the page in **style.css** and attached the necessary external links to the markup. With all of these in place, we can begin implementing the game's functionalities as we move to work with Javascript in [part two](./Part2.md) of the tutorial.
