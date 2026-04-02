# emacs
alias e='emacsclient --create-frame'
alias er='emacsclient --reuse-frame'
alias et='emacsclient --tty'

# python
alias pytest="pytest-3"
alias pycov="pytest-3 --cov"
alias black="find . -iname '*py' -exec black -l 120 '{}' +;"
alias isort="find . -iname '*py' -exec isort -l 120 -ns __init__.py '{}' +;"