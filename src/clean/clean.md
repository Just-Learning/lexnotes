# Clean

Transform raw data to a cleaned format and persist to local files

## Start a Jupyter Notebook


```bash
# pyenv
pyenv install 3
pyenv shell 3

# jupyter_env
python3 -m venv venv
source venv/bin/activate
python3 --version

# link venv as Jupyter kernel
pip3 install ipykernel
python -m ipykernel install --user --name=venv --display-name="venv"

# jupyterlab
pip3 install jupyterlab
jupyter lab # select the venv as python kernel
```

