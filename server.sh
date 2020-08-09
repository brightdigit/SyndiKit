apt update
apt -y full-upgrade
apt -y install tmux supervisor postgresql nginx zsh \
          binutils \
          git \
          gnupg2 \
          libc6-dev \
          libcurl4 \
          libedit2 \
          libgcc-9-dev \
          libpython2.7 \
          libsqlite3-0 \
          libstdc++-9-dev \
          libxml2 \
          libz3-dev \
          pkg-config \
          tzdata \
          zlib1g-dev

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
curl https://swift.org/builds/swift-5.2.5-release/ubuntu2004/swift-5.2.5-RELEASE/swift-5.2.5-RELEASE-ubuntu20.04.tar.gz | tar xzf - -C /usr/share/
mv /usr/share/swift-5.2.5-RELEASE-ubuntu20.04 /usr/share/swift
export PATH=/usr/share/swift/usr/bin:"${PATH}"

# download swift

# create db and user with password


# as orchardnest user
git clone https://github.com/brightdigit/OrchardNest.git app
swift build -c release --enable-test-discovery

sudo -u postgres createuser orchardnest
sudo -u postgres createdb orchardnest
sudo -u postgres psql -c "alter user orchardnest with encrypted password '12345';"
sudo -u postgres psql -c "grant all privileges on database orchardnest to orchardnest;"
