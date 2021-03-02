FROM archlinux:base-20210214.0.15477

# Thanks @MrCirdo for sharing this link
# https://stackoverflow.com/questions/66154574/archlinux-docker-ci-failed-to-initialise-alpm-library-returned-a-non-zero-cod/66163228#66163228
ARG patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst
RUN curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
bsdtar -C / -xvf "$patched_glibc"

RUN pacman -Syu --noconfirm git cmake clang automake autoconf dune gtest autoconf-archive boost gcc make flex bison

# RUN bsdtar -C / -xvf "$patched_glibc"

# RUN git clone https://aur.archlinux.org/include-what-you-use.git && cd include-what-you-use && makepkg -Arcsi

RUN bsdtar -C / -xvf "$patched_glibc"

RUN pacman -Scc --noconfirm

RUN mkdir /project

COPY ./command.sh /command.sh
WORKDIR /project
CMD /command.sh
