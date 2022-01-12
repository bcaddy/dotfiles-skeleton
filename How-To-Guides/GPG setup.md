# Setting up GPG to verify commits

## Installing/Verifying GPG itself

1. If you're on macOS install `gnupg` using `brew install gnupg` then reboot
2. Double check that you have GPG v2 or greater

## Generating the key pair

1. For gpg v2.1.17 or greater type `gpg --full-generate-key`, for earlier versions type `gpg --default-new-key-algo rsa4096 --gen-key`.  Some implementations don't like that syntax, if it isn't working run `gpg --help` and try to figure it out.
2. Now GPG should guide you through setting up your key pair.  Make sure to
choose RSA key, 4096 bits, set the key not to expire, use your verified
GitHub email, and choose a suitable passphrase.
3. Use `gpg --list-secret-keys --keyid-format LONG` to get your key ID which is the string on numbers and letters right after `sec  4096R/`
4. Run `gpg --armor --export KEY_ID` the copy and paste the results into GitHub

## Adding GPG Support to Git

1. Create a file named `~/.gitconfig_local` that looks like the example below.
   and add your GPG key ID in the appropriate place in that file.
2. Add the full path to `~/.gitconfig_local` in the `include` section of
   gitconfig, for some reason git won't expand the `~`

```git
[user]
  signingKey = KEY_ID
[commit]
  gpgSign = true #sign all commit by default
[tag]
  gpgsign = true #sign all tags by default
[gpg]
  program = gpg
```

## Cache GPG Passphrase

This is done so you don't have to enter your passphrase with every commit

1. Make sure gpg-agent and pinentry are installed
2. Add the following lines to `~/.gnugp/gpg.conf`

    ```txt
    default-key KEY_ID
    use-agent
    # Silences the "you need a passphrase" message
    # This is a potential source of issues, but I haven't noticed any
    batch
    ```

3. Create a new config file in`~/.gnugp/gpg-agent.conf` and add the following
lines making sure to expand all `~`.  You can find pinentry by running
`which pinentry`.  Set the arguments for `default-cache-ttl` and
`max-cache-ttl` to the length of time (in seconds) you want the passphrase
to be cached. (note that you might have to use `maximum` instead of `max`)

    ```txt
    use-standard-socket
    default-cache-ttl 28800 #cache for 8 hours
    max-cache-ttl 28800 #cache for 8 hours
    write-env-file ~/.gnupg/gpg-agent-info
    pinentry-program PATH-TO-PINENTRY
    ```

4. Now add the following to your bash_profile then reload the profile

    ```txt
    export GPG_TTY=$(tty) #forces terminal usage instead of GUI among other things
    ```

## Notes

* Deleting a key from GitHub unverifies all commits made with that key. They can be resigned and pushed again with a new key to verify them.
* might need to disable TTY with `echo 'no-tty' >> ~/.gnupg/gpg.conf1`
* restart gpg agent with `gpgconf --reload gpg-agent`
