#!/bin/bash

###
  #           __                      __             __    _
  #    _____ / /_ _____ __  __ _____ / /_ ___   ____/ /   (_)____
  #   / ___// __// ___// / / // ___// __// _ \ / __  /   / // __ \
  #  (__  )/ /_ / /   / /_/ // /__ / /_ /  __// /_/ /_  / // /_/ /
  # /____/ \__//_/    \__,_/ \___/ \__/ \___/ \__,_/(_)/_/ \____/
  #
  # con.structed.io - masterless Puppet bootstraper
  # bootstraps new instances for nodeless Puppet
  #
  # normal installation: sh -c "$(curl -s http://con.structed.io)"
  # verbose installation: sh -c "$(curl http://con.structed.io)" -- -v
  #
  # inspired by http://in.structed.io/shley
  #
  ##


### base config
RANDOM="$(perl -e 'print int(rand(300));')"
TIMESTAMP="$(date -R)"
PUPPET_RPM="http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm"
PUPPET_DIR="${HOME}/.puppet${RANDOM}"
PUPPET_LOCK="${PUPPET_DIR}/puppet-bootstrap.lock"
FILE_PUPPET_APPLY="${PUPPET_DIR}/puppet-apply.sh"
FILE_PUPPET_RUN="${PUPPET_DIR}/puppet-run.sh"
FILE_PUPPET_UPDATE="${PUPPET_DIR}/puppet-update.sh"
FILE_CRONTAB="${PUPPET_DIR}/puppet-crontab.txt"
FILE_LOG="${PUPPET_DIR}/constructedio.log"
ARGS_CURL="-s"
ARGS_RPM="--quiet --install"
ARGS_YUM="--assumeyes --quiet"


### ad-hoc config
while getopts "v" OPTION
do
  case ${OPTION} in
    v)
      ARGS_CURL="--verbose"
      ARGS_RPM="--install --verbose --hash"
      ARGS_YUM="--assumeyes"
        ;;
  esac
done
### end ad-hoc config


### convience function to echo and log with a single call
echolog()
{
  if [ -w "${FILE_LOG}" ]
  then
    echo "${1}"
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >> ${FILE_LOG}
  else
    echo "#####"
    echo -e "# You do not have write permissions for \e[0;31m${FILE_LOG}\e[00m, aborting."
    echo "#####"
    exit 1
  fi
}


### check if script is being run as root
if [ "$(id -u)" != "0" ]
then
  echo " "
  echo "#####"
  echo -e "# This script must be run as \e[0;31mroot\e[00m, aborting."
  echo "#####"
  echo " "
  exit 1

else
  ### check if script has been run before
  if [ ! -f "${PUPPET_LOCK}" ]
  then

    clear
    echo " "
    echo "#####"
    echolog "# con.structed.io masterless Puppet bootstrapper"
    echo "#####"
    echo " "

    ### create working directory and switch to it
    echolog "# 0 - creating working directory and switching to it"
    mkdir -p ${PUPPET_DIR}
    cd ${PUPPET_DIR}


    ### remove any installed versions of Puppet and Puppet Labs release RPM
    echolog "# 1 - removing previously installed versions of Puppet"
    yum ${ARGS_YUM} remove puppet > ${FILE_LOG} 2>&1
    yum ${ARGS_YUM} remove puppetlabs-release > ${FILE_LOG} 2>&1


    ### install remote RPM for Puppet Labs and clean YUM database
    echolog "# 2 - installing Puppet Labs Release RPM"
    curl ${ARGS_CURL} --remote-name ${PUPPET_RPM}
    yum ${ARGS_YUM} install puppetlabs-release*.rpm > ${FILE_LOG} 2>&1
    rm ${PUPPET_DIR}/puppetlabs-release*.rpm

    ### install Puppet via yum
    echolog "# 3 - installing Puppet"
    yum ${ARGS_YUM} install puppet > ${FILE_LOG} 2>&1


    ### loop while input is empty
    while [[ -z "${REPOSITORY_HOST}" ]]
    do
      echolog "# 4 - What is the HTTP(s) location of your Puppet manifests?"
      read REPOSITORY_HOST

      # detect repository type by looking at the last three characters of the
      # address; empty responses would indicate that this is not a git repo,
      # so default to svn instead
      REPOSITORY_TYPE="${REPOSITORY_HOST:${#REPOSITORY_HOST} - 3}"

      if [[ "${REPOSITORY_TYPE}" != "git" ]]
      then
        REPOSITORY_TYPE="subversion"
      fi
    done


    ### manually install VCS tools
    echo "# 4 - installing VCS tools"
    yum ${ARGS_YUM} install ${REPOSITORY_TYPE}


    ### create Puppet run scripts
    echo "# 5 - creating Puppet run scripts"
    # TODO(kerim): find way to get git / svn clone of files (see: CONSTRUCT-4)

    echo -n "puppet apply /etc/puppet/manifests/structed.pp" > ${FILE_PUPPET_APPLY}
    echo -n "${PUPPET_DIR}/${FILE_PUPPET_UPDATE}
  ${FILE_PUPPET_APPLY}" > ${FILE_PUPPET_RUN}


    ### create crontab file and add it to crontab
    echolog "# 6 - creating crontab"

    echo " " >> ${FILE_CRONTAB}
    echo "# generated by ${0} on ${TIMESTAMP}" >> ${FILE_CRONTAB}

    echo "*/15 * * * * sleep `perl -e 'print int(rand(300));'` && ${FILE_PUPPET_RUN} > /dev/null" > ${FILE_CRONTAB}


    echolog "# 7 - writing crontab for ${USER}"
    crontab -u ${USER} ${FILE_CRONTAB}


    echolog "# 8 - run puppet for the first time"
    echo "sh ${FILE_PUPPET_UPDATE}"
    echo "sh ${FILE_PUPPET_APPLY}"


    ### create lockfile
    echolog "# 9 - creating lockfile"
    echo -n "last run: ${TIMESTAMP}" > ${PUPPET_LOCK}

    echolog " "


  ### show warning if script has been run before
  else
    echo "#####"
    echolog "# ${PUPPET_LOCK} has been found, aborting."
    echo "#####"
  fi # end if for PUPPET_LOCK
fi # end if for root check