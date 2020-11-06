FROM akamai/shell

LABEL "com.github.actions.name"="Akamai Image Manager"
LABEL "com.github.actions.description"="Deploy Akamai Image Manager Policies"
LABEL "com.github.actions.icon"="cloud-lightning"
LABEL "com.github.actions.color"="orange"

LABEL version="0.1.0"
LABEL repository="https://github.com/Achuthananda/akamai-deploy-im-policy-github-action"
LABEL homepage=""
LABEL maintainer="Achuthananda"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
