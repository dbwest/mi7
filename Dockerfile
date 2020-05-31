# base
FROM ubuntu:bionic

# prereqs
RUN apt-get update -y
RUN apt-get -y install build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 -y

# setup cabal
RUN wget https://downloads.haskell.org/~cabal/cabal-install-3.2.0.0/cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
RUN tar -xf cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
RUN rm cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz cabal.sig
RUN mkdir -p ~/.local/bin
RUN cp cabal ~/.local/bin/
RUN cp cabal /bin/

# path, update, and check version
RUN export PATH="~/.local/bin:$PATH"
RUN echo "export PATH=\"~/.local/bin:$PATH\"" >> ~/.bashrc
RUN cabal update
RUN cabal --version

# GHC
RUN wget https://downloads.haskell.org/~ghc/8.6.5/ghc-8.6.5-x86_64-deb9-linux.tar.xz
RUN tar -xf ghc-8.6.5-x86_64-deb9-linux.tar.xz
RUN rm ghc-8.6.5-x86_64-deb9-linux.tar.xz
RUN cd ghc-8.6.5 && ./configure && make install && cd ..

# clone cardano-node
RUN git clone https://github.com/input-output-hk/cardano-node.git
RUN ls cardano-node
