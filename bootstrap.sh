#!/usr/bin/env sh
set -e

# Common constants
COLOR_RESET='\033[0m'
COLOR_GREEN='\033[0;32m'
COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-${PWD##*/}}"
TEST_HOST="${TEST_HOST:-localhost}"

echo "Integration test host: ${TEST_HOST}"

get_exposed_port() {
  if [ -z $3 ]
  then
    docker-compose port $1 $2 | cut -d: -f2
  else
    docker-compose port --index=$3 $1 $2 | cut -d: -f2
  fi
}

report_start() {
  printf "Waiting for $1 ... "
}

report_done() {
  printf "${COLOR_GREEN}done${COLOR_RESET}\n"
}

wait_for_healthy_containers() {
  IDs=$(docker-compose ps -q | paste -sd " " -)
  report_start "${1} containers to report healthy"
  counter="0"
  while true
  do
    if [ "$(docker inspect -f "{{.State.Health.Status}}" ${IDs} | grep -c healthy)" -eq "${1}" ]; then
      break
    fi
    counter=$((++counter))
    if [ "${counter}" -eq 120 ]; then
      echo " ERROR: containers failed to start"
      exit 1
    fi
    sleep 1
  done
  report_done
}

# Ensure Docker is Running
echo "Docker Information:"
echo ""
docker version
echo ""

# Activate the virtual environment
if test -e env/bin/activate
then
  . ./env/bin/activate
fi

# Stop any running instances and clean up after them, then pull images
docker-compose down --volumes --remove-orphans
docker-compose up -d --quiet-pull

wait_for_healthy_containers 1

cat > test.env <<EOF
export POSTGRES_HOST=${TEST_HOST}
export POSTGRES_PORT=$(get_exposed_port postgres 5432)
EOF

printf "\nBootstrap complete\n\nDon't forget to \". test.env\"\n"