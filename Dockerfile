FROM registry.fedoraproject.org/fedora:42


RUN dnf upgrade -y
RUN dnf install -y python3 \
                   python3-pip \
                   emacs \
                   texlive \
                   tmux \
                   nano \
		   pandoc \
                   python3-furo \
                   python3-sphinx_rtd_theme \
                   python3-sphinx-latex \
                   latexmk \
                   texlive-anyfontsize \
                   texlive-dvipng \
                   texlive-dvisvgm \
                   texlive-standalone 

RUN dnf install -y glibc.i686 \
                   libgcc.i686 \
                   glibc-devel.i686

ENTRYPOINT ["/entrypoint.sh"]

