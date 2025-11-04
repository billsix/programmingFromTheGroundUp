FROM registry.fedoraproject.org/fedora:43

ARG BUILD_DOCS=1
ARG USE_GRAPHICS=1

RUN sed -i -e "s@tsflags=nodocs@#tsflags=nodocs@g" /etc/dnf/dnf.conf && \
    echo "keepcache=True" >> /etc/dnf/dnf.conf && \
    dnf upgrade -y && \
    dnf install -y --skip-unavailable \
                glibc-devel.i686 \
                glibc.i686 \
                libgcc.i686 && \
    dnf install -y --skip-unavailable \
                   clang \
                   clang-tools-extra \
                   emacs \
                   g++ \
                   gcc \
                   gdb \
                   gtk4 \
                   gtk4-devel \
                   gtk4-demo \
                   lldb \
                   man \
                   man-db \
                   man-pages \
                   nano \
                   python3 \
                   tmux ; \
    if [ "$BUILD_DOCS" = "1" ]; then \
       dnf install -y \
                      latexmk \
                      libreoffice \
                      inkscape \
                      pandoc \
                      python3-furo \
                      python3-pip \
                      python3-sphinx-latex \
                      python3-sphinx_rtd_theme \
                      texlive \
                      texlive-anyfontsize \
                      texlive-dvipng \
                      texlive-dvisvgm \
                      texlive-standalone ; \
         fi ; \
    if [ "$USE_GRAPHICS" = "1" ]; then \
       dnf install -y \
                      mesa-dri-drivers  \
                      libXScrnSaver \
                      libXtst \
                      libXcomposite \
                      libXcursor \
                      libXdamage \
                      libXfixes \
                      libXft \
                      libXi \
                      libXinerama \
                      libXmu \
                      libXrandr \
                      libXrender \
                      libXres \
                      libXv \
                      libXxf86vm \
                      libglvnd-gles \
                      mesa-demos \
                      vulkan-tools  ; \
         fi ; \
    echo 'set debuginfod enabled off' > /root/.gdbinit

RUN         dnf install -y \
                    aspell \
                   aspell-en

COPY .clang-format /pgu/

RUN echo "source ~/.extrabashrc" >> ~/.bashrc

ENTRYPOINT ["/entrypoint.sh"]
