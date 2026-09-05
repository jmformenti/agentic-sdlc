# jq filter: keep only comments whose author is trusted — a repository
# collaborator, or one of the bots that post on behalf of the automation.
# Comments by anybody else are never fed to an agent that has write access.
def trusted:
  select((.author_association | IN("OWNER", "MEMBER", "COLLABORATOR"))
         or (.user.type == "Bot" and (.user.login | IN("claude[bot]", "github-actions[bot]"))));
