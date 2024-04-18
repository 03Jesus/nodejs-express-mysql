#!/usr/bin/env bash
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
export PATH="$PATH:/usr/bin"
sleep 10
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.315.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.315.0/actions-runner-linux-x64-2.315.0.tar.gz
echo "6362646b67613c6981db76f4d25e68e463a9af2cc8d16e31bfeabe39153606a0  actions-runner-linux-x64-2.315.0.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.315.0.tar.gz
sleep 5
printf '\n' && sleep 5 && printf '\n' && sleep 5 && printf '\n' && sleep 5 | ./config.sh --url https://github.com/03Jesus/nodejs-express-mysql --token A5YOBNFUMMZIUAREL4XPGVDGEF6WI
./svc.sh install
./svc.sh start
sleep 10
sudo apt update
sudo apt install -y git python3-pip ansible
pip3 install ansible
git clone https://github.com/03Jesus/nodejs-express-mysql.git
cd nodejs-express-mysql/ansible
ansible-playbook node.yml