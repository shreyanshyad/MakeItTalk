# set up env

- use `virtualenv` to create a Python 3.10.10 environment named `venv`
- activate the environment `source venv/bin/activate`
- install dependencies `pip install -r requirements.txt`
- install ffmpeg `sudo apt-get install ffmpeg`
- wine install ( just install winehq-stable by any means )
  ```
  sudo dpkg --add-architecture i386
  wget -nc https://dl.winehq.org/wine-builds/winehq.key
  sudo apt-key add winehq.key
  sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main'
  sudo apt update
  sudo apt install --install-recommends winehq-stable
  ```
- do pretrained models and animate your portraits step from README
- test `./run.sh` with any file this should create a filename.mp4 in the base directory
