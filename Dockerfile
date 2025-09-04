FROM registry.fedoraproject.org/fedora:42

# I want man packages, this is a development container
RUN sed -i -e "s@tsflags=nodocs@#tsflags=nodocs@g" /etc/dnf/dnf.conf

RUN dnf upgrade -y
RUN dnf install -y clang \
                   emacs \
                   g++ \
                   gcc \
                   gdb \
                   glibc-devel.i686 \
                   glibc.i686 \
                   latexmk \
                   libgcc.i686 \
                   lldb \
                   man \
                   man-db \
                   man-pages \
                   nano \
		   pandoc \
                   python3 \
                   python3-furo \
                   python3-pip \
                   python3-sphinx-latex \
                   python3-sphinx_rtd_theme \
                   texlive \
                   texlive-anyfontsize \
                   texlive-dvipng \
                   texlive-dvisvgm \
                   texlive-standalone \
                   tmux

RUN dnf install -y inkscape
RUN dnf install -y libreoffice

RUN echo 'set debuginfod enabled off' > /root/.gdbinit

ENTRYPOINT ["/entrypoint.sh"]
