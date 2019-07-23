provider "pass" {
  store_dir     = "~/.password-store" # defaults to $PASSWORD_STORE_DIR
  refresh_store = false               # do not call `git pull`
}
