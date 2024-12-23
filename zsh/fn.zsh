kill-port () {
  echo $(lsof -t -i tcp:$1 | xargs kill)
}

kill9-port () {
  echo $(lsof -t -i tcp:$1 | xargs kill -9)
}

# tools
curl-d() {
  curl -s -D - "$1" -o /dev/null
}

proxy() {
  curl-d "http://localhost:8080/proxy?url=$1"
}

# ssl
ssc-gen(){
  name="$1";
  ssl_pass="$PWD/$name.pass.key";
  ssl_req="$PWD/$name.csr";
  ssl_sign="$PWD/$name.key";
  ssl_cert="$PWD/$name.crt";

  openssl genrsa -des3 -passout pass:x -out $ssl_pass 2048
  openssl rsa -passin pass:x -in $ssl_pass -out $ssl_sign
  rm $ssl_pass
  openssl req -new -key $ssl_sign -out $ssl_req
  openssl x509 -req -sha256 -days 365 -in $ssl_req -signkey $ssl_sign -out $ssl_cert
}

sslv3-key() {
  dir="$HOME/CA"
  ca_cert="$dir/ca_cert.csr"
  ca_key="$dir/ca_key.key"
  conf="$dir/openssl.cnf"

  res_csr="$PWD/$1.csr"
  res_crt="$PWD/$1.crt"
  res_key="$PWD/$1.key"

  echo "Creating $res_csr";
  echo "Creating $res_crt";
  echo "Creating $res_key";

  if ! [ -e "$res_csr" ]; then
    echo "Generating SSL x509v3 key for $1"
    echo "New dir added $dir"
    mkdir -p $dir

    if [ ! -f "$conf" ];
    then
      echo "Copy OpenSSL config"
      cp "/usr/local/etc/openssl/openssl.cnf" $dir
    else
      echo "Config found in $dir"
    fi

    echo "Creating CA [$ca_key]"
    openssl req -x509 -new -extensions v3_ca -keyout $ca_key -out $ca_cert -days 365 -config $conf

    echo "Creating certificate signing request [$res_csr]"
    openssl genrsa 1024 > $res_key
    openssl req -new -key $res_key -out $res_csr -extensions v3_req -config $conf
  else
    echo "Certificate found in $PWD: $res_scr"
  fi

  echo "Signing CSR with CA [$res_crt]"
  openssl x509 -req -days 365 -in $res_csr -CA $ca_cert -CAkey $ca_key -CAcreateserial -out $res_crt -extfile $conf
  openssl x509 -text -noout -in $res_crt
}

openssl-gen(){
  sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$1.key" -out "$1.crt"
}

p12-convert () {
  openssl pkcs12 -in $1 -out $2 -nodes -clcerts
}

pem-test () {
  cert="$1"
  mode="$2"
  endpoint="gateway.sandbox.push.apple.com:2195"

  if [[ $mode == "-production" ]];
  then
    endpoint="gateway.push.apple.com:2195"
  fi

  openssl s_client -connect $endpoint -cert $cert -key $cert
}

# nginx
nginx-reset(){
  sudo nginx -s stop
  sudo rm -rf /usr/local/var/run/nginx/*
  sudo nginx
}

list-submodules() {
  local submodules_str=$(git config --file .gitmodules --get-regexp path | awk '{ print $2 }')
  echo $submodules_str | tr '\n' ' '
}

switch-branch() {
  local branch="$1"
  local submodules=(`list-submodules`)

  main-branch() {
    git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
  }

  branch-exists() {
    local branch_name=$1

    if [ "`git branch --list $branch_name`" ]
    then
      echo true
      return
    fi

    echo false
  }

  switch-branch () {
    git fetch
    local branch=$1
    local name=$2

    if [[ $branch == "main" ]];
    then
      echo "Switching $name to main branch"
      branch="$(main-branch)"
    fi

    if [[ $(branch-exists $branch) == true ]];
    then
      echo "Switching $name to $branch"
      git checkout -q $branch
    else
      echo "Skipped $name: branch $branch does not exist"
    fi
  }

  for submodule in "${submodules[@]}"
  do
    cd $submodule
    switch-branch $branch $submodule
    cd ..
  done

  switch-branch $branch "LSE"
}

pull-all() {
  local submodules=(`list-submodules`)

  for submodule in "${submodules[@]}"
  do
    echo "Pulling $submodule"
    cd $submodule
    git fetch --tags -f
    git pull
    cd ..
  done

  git fetch --tags -f
  git pull
}

# git
cherry(){ git cherry -v $1 }
cherry-length(){ git cherry -v $1 | wc -l }
alias cherry-pick="git cherry-pick"

# FS
cdm() {
  mkdir -p $1 && cd $1
}
