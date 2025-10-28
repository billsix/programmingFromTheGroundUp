FROM registry.fedoraproject.org/fedora:43

ARG BUILD_DOCS=1
ARG USE_GRAPHICS=1

RUN sed -i -e "s@tsflags=nodocs@#tsflags=nodocs@g" /etc/dnf/dnf.conf && \
    echo "keepcache=True" >> /etc/dnf/dnf.conf && \
    dnf upgrade -y && \
    dnf install -y clang \
                   clang-format \
                   emacs \
                   g++ \
                   gcc \
                   gdb \
                   glibc-devel.i686 \
                   glibc.i686 \
                   gtk4 \
                   gtk4-devel \
                   gtk4-demo \
                   libgcc.i686 \
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

COPY .clang-format /pgu/

ENTRYPOINT ["/entrypoint.sh"]
