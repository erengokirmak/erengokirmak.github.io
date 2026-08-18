+++
date = '2026-07-06T15:02:07+03:00'
draft = false
title = 'pass(word) management'
description = "my journey into using a password manager"
tags = [ "Journalistic Writing", "tools" ]
showToc = false

[cover]
image = ""
alt = "Descriptive alt text"
caption = "Optional caption text"
relative = false
hidden = false
+++

I've wanted to get proper password management for a long while. I guess I've had an irrational repulsion from password managers in the past but I understand that they have many benefits in terms of security and ease of use. However, this is provided that the manager stores passwords securely.

The approach I landed on is using [`pass`](https://www.passwordstore.org/), a password manager inspired by the unix philosophy. It uses the OpenPGP standard and a directory-based approach to storing encrypted passwords. I liked the idea, since its file-based structure allows the password store to be used with `git` and be synced with any device that can use git. I guess I really enjoy version controlling everything in my life :p

## Public-key Cryptography
Before you can use `pass`, you need an OpenPGP key. Under the hood, `pass` uses [GnuPG](https://www.gnupg.org/) as its encryption backend. To create a such a key, one can use a command such as `gpg --full-generate-key`, allowing you to select what kind of key you want. The key type determines what kind of asymmetric encryption will be used. For example, I selected ECC for both signature and encryption. After this, you end up with a key ID.

### A side note
The key you get is a full-fledged OpenPGP key, which is a general purpose key. A nice idea would be to upload this key to a keyring such as the [OpenPGP keyring](https://keys.openpgp.org/) to use to authenticate yourself. I suggest reading about [OpenPGP](https://www.openpgp.org/) and learning the use cases it has. My key can be found [here](/pub.asc) with fingerprint `24AB 3E4F CE8F C62B DEC9  6D98 559A 7643 109E AA79`. The OpenPGP keyring also has the same public key under my email.

## Initializing a `pass`word store
`pass` uses your key ID to determine the credentials with which to encrypt your passwords. You initialize a password store with the command:

```sh
pass init "<your_key_id>"
```

This command creates a `~/.password-store` directory to store your encrypted password and writes a file `.gpg-id` to associate the store with the key ID you provide.

## Encrypting Passwords

Each time you want to encrypt a password, `pass` uses the standard OpenPGP encryption protocol:
1. Generate a random one-time session key,
2. Encrypt the data with AES-256 using the session key,
3. Encrypt the session key with the public key of the GPG encryption subkey,
4. Bundle all the encrypted information, along with metadata about the encryption, in a `.gpg` file.

The implication is that every time you want to use your passwords, `pass` takes the private encryption subkey you have on your machine, uses it to decrypt the session key, and decrypts the password you want to use. To me, this is a genius way to use public-key cryptography to manage a system like this. Another upside of this system is that you can freely carry your password store. As long as you protect your private key, the password store is useless to a malicious attacker (assuming the cryptographic scheme is secure, obviously).

## Adding `git`
`pass` allows for git integration. You can create a repository using `pass git init`. In fact, virtually all `git` commands have their `pass git` counterparts. However, other than pulling or pushing your repo, you may not need to use these commands as each change to the password store through `pass` automatically gets committed.

## More Usage
Following the initialization, I went through all the platforms I have a password for, and changed them with passwords generated using the command:

```sh
pass generate "<platform.com>"
```

You can then use `pass list` to list the passwords you have.

```tree
Password Store
├── personal
│   ├── firefox.com
│   ├── instagram.com
│   └── youtube.com
└── work
    ├── github.com
    ├── gmail.com
    ├── linkedin.com
    ├── orcid.org
    └── overleaf.com
```

You can see a truncated version of my password store above. Here, if I wanted to see the password for my ORCID account for example, I would use the `pass show work/orcid.org` command (with `pass work/orcid.org` being a shorthand).

## Some More Implications
Since "Sign-In with Google" and its alternatives are quite common these days, I have to log in to a lot fewer platforms with passwords than I used to. However, to make sure my passwords are independent of each other in the few platforms that require passwords, I'm using randomly generated passwords from `pass`.

One concern I had with using `pass` was whether there was an easy way to share passwords to devices that didn't have `pass` set up. However, for one-time uses, the tool comes with a flag for the `show` command:

```sh
pass show --qrcode "<domain.com>"
```

which displays a QR code of the password. Additionally, tools like [Android-Password-Store](https://github.com/agrahn/Android-Password-Store) allow you to use the same password store on your Android devices. I have yet to configure the store in my Windows machine, however I haven't needed to either. I guess logging into Google is good enough for that side.