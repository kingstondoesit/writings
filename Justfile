[doc("List available commands")]
default:
    just --list 


[doc("Install dependencies")]
install-dependencies:
    cargo install --version 0.4.51 mdbook
    cargo install --version 0.8.0 mdbook-alerts
    cargo install --version 0.2.9 mdbook-repl
    cargo install --version 0.4.0 mdbook-quiz
    cargo install --version 0.15.0 mdbook-mermaid
    cargo install --version 0.2.2 mdbook-last-changed
    cargo install --version 0.2.3 mdbook-tabs


[doc("Build the book and open it in the browser")]
watch:
    mdbook serve --open --port 3001 

[doc("Checkout a pull request to a new branch")]
checkout-pr PR_NUMBER BRANCH_NAME: 
    git fetch origin pull/${PR_NUMBER}/head:${BRANCH_NAME}
    git checkout ${BRANCH_NAME}