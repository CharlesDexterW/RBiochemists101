## set your user name and email:
usethis::use_git_config(user.name = "CharlesDexterW", user.email = "agarces2381@gmail.com")

## create a personal access token for authentication:
usethis::create_github_token() 
## in case usethis version < 2.0.0: usethis::browse_github_token() (or even better: update usethis!)

## set personal access token:
credentials::set_github_pat("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")

## or store it manually in '.Renviron':
## - usethis::edit_r_environ()
## store your personal access token in the file that opens in your editor with:

GITHUB_PAT=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

## and make sure '.Renviron' ends with a newline

