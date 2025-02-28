# AI-Generated GIT Commit Messages - Why and How: Cloud Options

## Table of Content

- [AI-Generated GIT Commit Messages - Why and How: Cloud Options](#ai-generated-git-commit-messages---why-and-how-cloud-options)
  - [Table of Content](#table-of-content)
  - [Prerequisites](#prerequisites)
  - [Auto-Generate Commits with Copilot](#auto-generate-commits-with-copilot)
    - [Generate Commit Messages with Copilot UI](#generate-commit-messages-with-copilot-ui)
    - [Generate Commit Messages via Github Copilot CLI](#generate-commit-messages-via-github-copilot-cli)
    - [Limitations](#limitations)
    - [Recommendations](#recommendations)
  - [GIT AI Commit by *The-Cafe*](#git-ai-commit-by-the-cafe)
    - [Setting up git-ai-commit](#setting-up-git-ai-commit)
    - [Limitations](#limitations-1)
    - [Recommendations](#recommendations-1)
  - [Auto Git Commit (autogitc)](#auto-git-commit-autogitc)
    - [Installation and Setup](#installation-and-setup)
    - [Limitations](#limitations-2)
    - [Recommendation](#recommendation)
  - [Conclusion](#conclusion)

One crucial aspect of web and software development is version control and a project's commit history is its story, written one change at a time.

The ability to collaborate effectively and reference to a specific state in a project's timeline is facilitated by accurate commits; yet, crafting clear, consistent commit messages can often feel like a tedious disruption in the workflow of many developers who understand their significance in the short and long term.

This article introduces easy-to-use AI-powered options that lessen the developer burden of manually drafting adequate commit messages. We'll show you how to adopt each one and highlight probable limitations.

## Prerequisites

- Introductory knowledge of Git.
- An Integrated Development Environment (VScode preferred).
- An existing Git-tracked project/repo.

## Auto-Generate Commits with Copilot

GitHub Copilot is Microsoft's flagship AI programming assistant. It seamlessly integrates with VScode and is capable of analyzing diffs (short for differences) in code versions to suggest appropriate commit messages. It does this by comparing the content of staged files with the content of the most recent commit in a project's git repository.

Although we'll be using VScode for demonstration, Copilot can be deployed and utilized on [several other IDEs](https://docs.github.com/en/copilot/managing-copilot/configure-personal-settings/installing-the-github-copilot-extension-in-your-environment).

### Generate Commit Messages with Copilot UI

To set up Copilot as a commit message-generating tool in your workspace, first, install GitHub Copilot and Github Copilot chat extensions from the VScode extension marketplace.

![copilot-ext](https://hackmd.io/_uploads/SkxEixIH1x.png)

After both extensions install  successfully, press **Control + Command + i** (Mac) / **Ctrl + Alt + i** (Windows/Linux) to open the copilot chat window and click **Sign in to GitHub[dot]com** to sign in to copilot.

![copilot-chat](https://hackmd.io/_uploads/BJcIdRHr1l.png)

Once signed in to copilot, open the VS code source control menu or press **Ctrl+Shift+G**.

Stage file changes in your local git branch and then click the *sparkle icon* in  to generate a commit message.

![generate-commit-button](https://hackmd.io/_uploads/B1x-1GVrkx.png)

You can then review the generated message, make neccesary modifications, commit changes, and push commits to your cloud git host (eg. github).

### Generate Commit Messages via Github Copilot CLI

If you prefer using the terminal instead of the source control user interface, do the following:

1. First install Github CLI with popular installation packages like chocolatey (Windows) or homebrew (macOS).

    **For Windows**

    ```sh
    $ choco install gh
    ```

    **For macOS**

    ```sh
    $ brew install gh
    ```

2. Authenticate Github CLI.

    ```sh
    $ gh auth login
    ```

3. Go through the instructions and select the appropriate options. Crucially, copy the one-time code and enter it in your browser.

    ```txt
    ? Where do you use GitHub? GitHub.com
    ? What is your preferred protocol for Git operations on this host? HTTPS
    ? Authenticate Git with your GitHub credentials? Yes
    ? How would you like to authenticate GitHub CLI? Login with a web browser

    ! First copy your one-time code: XXXX-XXXX
    Press Enter to open https://github.com/login/device 
    in your browser... 
    ✓ Authentication complete.
    - gh config set -h github.com git_protocol https
    ✓ Configured git protocol
    ✓ Logged in as <your_username>
    ```

4. After authentication completion, proceed to install (or update) the Github Copilot CLI extension.

    ```sh
    $ gh extension install github/gh-copilot
    $ gh extension upgrade gh-copilot
    ```

5. You should now be able to use the sparkle icon in the terminal like this:

    ![copilot-git-terminal-X-ezgif.com-video-to-gif-converter](https://hackmd.io/_uploads/BJgivNSS1x.gif)

If you find the above Copilot setup procedure inaccurate due to IDE differences, you might want to consult [this guide](https://docs.github.com/en/copilot/managing-copilot/configure-personal-settings/installing-the-github-copilot-extension-in-your-environment) for specific details regarding its integration in your IDE.

![image](https://hackmd.io/_uploads/SJR9fQHSyl.png)

### Limitations

As with any free-tier product, there are certain limitations to what the free version of copilot offers. 

Microsoft imposes that **Copilot allows only 50 messages and 2000 auto code completions per month**. This consequently implies some degree of constraint on the number of commit message generations you can do within a 30-day period.

### Recommendations

Microsoft Copilot is an excellent AI assistant choice. We recommend that you/your organization try Copilot before other alternatives, which we'll cover shortly.

However, if your revenue outlook is solid, we strongly recommend you upgrade to the Copilot Pro tier for $10 per month or $100 annually.

## GIT AI Commit by *The-Cafe*

[`git-ai-commit`](https://github.com/the-cafe/git-ai-commit) is a third-party AI commit message generating tool built with python by [the-cafe](https://github.com/the-cafe). Compared to Copilot which provides default LLM access to Claude 3.5 Sonnet and OpenAI’s GPT-4o models, it supports a variety of models provisioned by OpenAI, Anthropic, and locally hosted Ollama. (Full list [here](https://github.com/the-cafe/git-ai-commit/blob/a1e62be64c1f877bfa26c45d2d61508f94504ec0/ai_commit_msg/utils/models.py#L1)).

### Setting up git-ai-commit

To set up and use `git-ai-commit` in your project, first make sure you have python installed on your development workstation.

Once that's done, follow the instructions below.

1. Download and install the package.

    ```sh
    $ pip install git-ai-commit
    ```

2. Install and upgrade set up tools\

    ```sh
    $ pip install --upgrade setuptools 
    ```

3. Verify `git-ai-commit` package installation.

    ```sh
    $ git-ai-commit --version 
    ```

    You'll have to add the package folder to your system environment variable path manually if this returns an error, otherwise proceed on **Step 7**.

4. Locate the Python packages installation directory in your system using the following command.

    ```sh
    $ python -m site --user-site  
    ```

    You should get a response similar to this.

    ```txt
    C:\Users\<YOUR_USERNAME>\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\site-packages
     ```

5. Modify the path response above by replacing the tail-end folder `site-packages` with `Scripts`.

    ```txt
   C:\Users\<YOUR_USERNAME>\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\Scripts
    ```

6. Add the modified path to System Environment Variables.

   - Open the **Start Menu** and search for **Environment Variables**.

   - Select **Edit the system environment variables**.

   - In the **System Properties window**, click on the **Environment Variables** button.

     ![SystemPropertiesWindow](https://hackmd.io/_uploads/rkzA1Vudyx.png)

   - In the **Environment Variables window**, under **System variables**, find and select the `Path` variable, then click **Edit**.

   - In the **Edit Environment Variable** dialog, click **New** and paste the path to the Scripts directory (*C:\Users\\<YOUR_USERNAME>\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\Scripts*).

     > **Important**: The above path is totally subjective to your system's PIP package install location; make sure you add the right path.

   - Click **OK** to close all dialog boxes.

7. Configure package with the `config --setup` flag.

    ```sh
    $ git-ai-commit config --setup
    ```

    When you run this command, you may encounter the error attached below. Skip the steps addressing  the error if that is not the case and continue on **Step 9**.

    ```txt
    Welcome to AI Commit MSG! Let's get you set up.

    [Setup] Git prepare-commit-msg hook
    Traceback (most recent call last):
      File "<frozen runpy>", line 198, in _run_module_as_main
      File "<frozen runpy>", line 88, in _run_code
      File "C:\Users\USER_NAME\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\Scripts\git-ai-commit.exe\__main__.py", line 7, in <module>
      File "C:\Users\USER_NAME\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\site-packages\ai_commit_msg\main.py", line 154, in main
        config_handler(args)
      File "C:\Users\USER_NAME\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\site-packages\ai_commit_msg\cli\config_handler.py", line 50, in config_handler
        handle_config_setup()
      File "C:\Users\USER_NAME\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\site-packages\ai_commit_msg\cli\config_handler.py", line 9, in handle_config_setup
        onboarding_flow()
      File "C:\Users\USER_NAME\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\site-packages\ai_commit_msg\services\onboarding_service.py", line 81, in onboarding_flow
        setup_git_hook()
      File "C:\Users\USER_NAME\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\site-packages\ai_commit_msg\cli\hook_handler.py", line 99, in setup_git_hook
        handle_setup_hook(file_path)
      File "C:\Users\USER_NAME\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\site-packages\ai_commit_msg\cli\hook_handler.py", line 56, in handle_setup_hook
        file.write(get_bash_script())
      File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.12_3.12.2288.0_x64__qbz5n2kfra8p0\Lib\encodings\cp1252.py", line 19, in encode
        return codecs.charmap_encode(input,self.errors,encoding_table)[0]
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    UnicodeEncodeError: 'charmap' codec can't encode characters in position 273-274: character maps to <undefined>
    ```

    The above *UnicodeEncode* error indicates that python is trying to encode characters to a text file using an unsupported character-encoding format.

8. To address this error, open `hook_hanler.py` from the file paths listed in the error message "*C:\Users\USER_NAME\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\site-packages\ai_commit_msg\cli\hook_handler.py*"

    Locate the `handle_setup_hook(hook_directory_path: str)` function and replace it with the following:

    ``` python
    ...
    
    def handle_setup_hook(hook_directory_path: str):
        existing_hook_content = ""
        if os.path.exists(hook_directory_path):
            with open(hook_directory_path, "r", encoding='utf-8') as file: # Adds encoding='utf-8' to open() function to read the hook file
                existing_hook_content = file.read()

        if existing_hook_content == get_bash_script():
            Logger().log("prepare-commit-msg hook already exists")
            return

        if existing_hook_content:
            override_content = input(
                f"prepare-commit-msg hook already exists in {hook_directory_path}\n\nWould you like to overwrite it? (y/n): "
            )

            if override_content.lower() == "n":
                return
            elif override_content.lower() != "y":
                Logger().log("Invalid input. Exiting.")

        ## create the prepare-commit-msg file and write the hook code
        with open(hook_directory_path, "w", encoding='utf-8') as file: # Adds encoding='utf-8' to open() function to write to bash script
            file.write(get_bash_script())

        # make the file executable
        os.chmod(hook_directory_path, 0o755)
        
        ...
    ```

    >**Note:** ... indicates unchanged code.

    **Save** the file.

    This should fix the *UniEncode* error and let you proceed to choose your preferred LLM provider after you rerun the command `git-ai-commit config --setup`.

9. Select your preferred large language provider and model.

    OpenAI and Anthropic each require an API key for LLM access - we'll use OpenAI.

    To obtain an OpenAI API key, [log in to OpenAI](https://platform.openai.com/api-keys) and create one.

    Choose **OpenAI** and **gpt-40-mini** as your AI provider and model respectively, then enter the obtained API key. (other models require a paid subscription).

    ```txt
    Welcome to AI Commit MSG! Let's get you set up.

    [Setup] Git prepare-commit-msg hook
    prepare-commit-msg hook already exists in .git/hooks/prepare-commit-msg

    Would you like to overwrite it? (y/n): n

    Choose your preferred AI provider:
    [?] Select AI Provider:
     > OpenAI
       Anthropic
       Ollama

    [?] Select Model:
       gpt-4-0125-preview
       gpt-4-turbo-preview
       gpt-4-vision-preview
       gpt-4-1106-vision-preview
       gpt-4-turbo
       gpt-4-turbo-2024-04-09
       gpt-4-32k
       gpt-4-32k-0314
       gpt-4-32k-0613
       gpt-4o
       gpt-4o-2024-05-13
     > gpt-4o-mini
       gpt-4o-mini-2024-07-18

    Let's set up your Openai API key.
    [?] Enter your Openai API key: sk-XXXXXXXXXXX
    ```

    On successful API key entry, you'll be asked to enable event logging feature. Confirm (y) or decline (N) to complete setup.

    ![API-key-successful](https://hackmd.io/_uploads/SkzwuC8Bkg.png)

10. Run config command to view configuration settings.

    ```sh
    $ git-ai-commit config
    ```

    ```txt
    Settings
    ----------------------
    Anthropic Api Key: 
    Openai Api Key: sk-proj-...154j
    Logger Enabled: True
    Model: gpt-4o-mini
    Ollama Url: http://localhost:11434/api/chat
    Last Updated At: 2024-12-23 13:26:54
    Max Length: 50
    ```

11. Finally, stage file changes and generate commit message.

    ```sh
    $ git add .
    $ git-ai-commit summarize
    ```

    Below is an example response from GPT-4o-mini assuming the API key provided is valid:

    ```txt
    Fetching your staged changes...

    Here is a summary of your changes:

      added ai-generated commit message guidelines document

    to use this summary run: `git commit -m "added ai-generated commit message guidelines document"`
    ```

All `git-ai-commit` configuration options and their implementation are outlined in [this documentation](https://github.com/the-cafe/git-ai-commit#%EF%B8%8F-cli-commands--options).

### Limitations

`git-ai-commit` usage is only limited by your API key and subscription [rate limit](https://platform.openai.com/docs/guides/rate-limits). For example, Open AI restricts free-tier accounts API use to 40,000 - 60,000 tokens per minute and 200 requests per day. You can increase this limit by buying OpenAI credits or upgrading your account.

### Recommendations

Aside the seemingly unstable nature of the package, which results in an avoidably lengthy setup process, it is a more versatile AI commit message tool considering the variety of model options it supports.

## Auto Git Commit (autogitc)

[`autogitc`](https://github.com/adriangohjw/autogitc) is a Ruby package built by [Adrian Goh Jon Wei](https://github.com/adriangohjw) to help developers write clear and consistent commit messages. It uses GPT-4o-Mini which is OpenAI's most cost effective model.

### Installation and Setup

To use `autogitc` in your project, follow these steps.

1. Visit [rubyinstaller.org](https://rubyinstaller.org/Install) to download and install Ruby or use OS installation packages.

    **For Windows**

    ```sh
    $ choco install ruby
    ```
  
    **For macOS**

    ```sh
    $ brew install ruby
    ```

2. Verify package installation.

    ```sh
    $ ruby -v
    ```

3. Install gem bundler (not mandatory).

    ```sh
    $ gem install bundler
    ```

    >**Note**: You may have to restart your IDE and terminal to integrate Ruby and gem bundler installations.

4. Install `autogitc` with gem package installer. 

    ```sh
    $ gem install autogitc
    ```

5. Set `AUTOGITC_KEY` key as the API key obtained from OpenAI in your system environment variables.

    You can do this easily in the powershell terminal using the following command. (replace the placeholder with your key - retain apostrophes)

    ```sh
    $ [System.Environment]::SetEnvironmentVariable('AUTOGITC_KEY', 'your_openai_api_key_here', [System.EnvironmentVariableTarget]::User)  
    ```

6. Verify environment variable addition.

    ```sh
    $ Get-ChildItem Env:AUTOGITC_KEY
    ```

    You should see your API key returned in the terminal.

    You can also verify or set the key via your system environment variables window.

   ![image](https://hackmd.io/_uploads/rkSVgtZ81e.png)

7. Stage file changes, then run `autogitc` to automatically generate commit message and commit changes.

    ```sh
    $ git add .
    
    $ autogitc
    ```

    For reviewability purposes, we recommend that you use the `--nc` (or `--nocommit`) flag instead to generate commit messages.

    ```sh
    $ autogitc --nc
    ```

    You should get a success response that looks like this:

    ```txt
    Running autogitc...
    Generated commit message:
    Add AI-Generated GIT Commit guidelines and API key image
    ```

    > **N/B**: You can also add the --text=XXX flag to indicate specific text(s) that must be included in the commit message.
    Replace XXX with the text you wish to include.

    Review commit message suggestion and make changes (where necessary) to be more precise.

### Limitations
As mentioned earlier, with `autogitc` you're restricted to just one LLM model, which is Gpt-4o-mini, unlike Copilot and `git-ai-commit` that offer multiple LLM provider options.

### Recommendation

`autogitc` is a great choice if you want to try a quick, straight forward third-party option with its only configuration requirement being your OpenAI API key.

## Conclusion

In ~10 minutes, you’ve learned to use AI tools to ease and refine the project version documentation process.

We've covered three different options that analyze code changes to produce contextual commit messages and provided practical steps on how you can adopt them.

While these tools do not completely alleviate your responsibility of ensuring that commit messages are clear, informative, and relevant, they help maintain conventional commit standards and offer solid starting points.

Go make your project's story better, one commit message at a time.
