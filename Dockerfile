FROM archlinux

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm \
  git \
  python \
  python-pip \
  vim \
  which

RUN pip install --upgrade pip
RUN pip install "ansible>=2.0,<3.0"

RUN mkdir /sheepdoge-test

WORKDIR /sheepdoge-test

ADD tasks ./tasks
ADD vars ./vars
ADD tests/* ./

RUN chmod u+x test.sh
