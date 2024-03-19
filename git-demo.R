library(usethis)
use_git_config(
  user.name = "",     # your full name
  user.email = ""  # email associated with GitHub account
)

git_sitrep() # current situation report
git_vaccinate() # add files to global .gitignore (best practice)

usethis::create_github_token()

gitcreds::gitcreds_set()

#By default token will expire after 30 days.
#Return to https://github.com/settings/tokens and click on its Note
#or else click on link in e-mail telling you token is about to expire!
#  Regenerate token
#rerun gitcreds::gitcreds_set()


usethis::edit_r_profile()
