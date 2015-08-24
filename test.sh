#!/bin/sh -ex

cd chainer
python setup.py -q install

pip install -q nose mock coverage coveralls

nosetests --processes=12 --process-timeout=10000 --with-coverage --cover-branches --cover-package=cupy tests/cupy_tests
nosetests --with-coverage --cover-branches --cover-package=chainer tests/chainer_tests

coverage xml -i

if [ $COVERALLS_REPO_TOKEN ]; then
  coveralls
fi
