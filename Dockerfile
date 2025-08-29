FROM registry.fedoraproject.org/fedora:42


RUN dnf upgrade -y
RUN dnf install -y python3 \
                   python3-pip \
                   emacs \
                   tmux \
                   nano \
		   pandoc \
                   python3-furo \
                   python3-sphinx_rtd_theme


ENTRYPOINT ["/entrypoint.sh"]

