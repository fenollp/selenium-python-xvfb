# Selenium3 + xvfb with Python3 API on docker

Forked from: [pimuzzo/selenium-python-xvfb](https://hub.docker.com/r/pimuzzo/selenium-python-xvfb/)
Which was forked from: [khozzy/selenium-python-chrome](https://hub.docker.com/r/khozzy/selenium-python-chrome/)
Inspiration: [SO Q&A](http://stackoverflow.com/a/6300672/1418165)

## build

Either
* `docker build -t selenium .` (in the same path of your Dockerfile)
* `docker pull fenollp/selenium`

## run

### Play around with the test script

```shell
docker run --name sel -ti --rm fenollp/selenium bash
root@c4c58976c69a:/# python3 /home/example.py
Google
```

### Use container with your own data

```shell
docker run -ti --rm -v /your_local_dir:/home/something fenollp/selenium python3 /home/something/your_file.py
```

Optional:
- You can specify the browser with the `BROWSER` environment variable (defaults to `firefox`)

## example.py

```python3
#!/usr/bin/env python3

from pyvirtualdisplay import Display
from selenium import webdriver

display = Display(visible=0, size=(800, 600))
display.start()

# now Firefox will run in a virtual display.
# you will not see the browser.
browser = webdriver.Firefox()
browser.get('http://www.google.com')
print(browser.title)
browser.quit()

display.stop()
```
